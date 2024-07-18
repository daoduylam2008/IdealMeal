'use server';
import { decodeJwt } from 'jose';
import { cookies } from 'next/headers';

import dbConnect from '../database';
import instance from '../axios-instance';
import Meal from '../models/Meal';
import User from '../models/User';
import Otp from '../models/Otp';
import Feedback from '../models/Feedback';

const token = cookies().get('token').value;
const id = Number.parseInt(decodeJwt(token).sub);

// Profile page

export const getProfile = async () => {
  const [profile, me] = await Promise.all([
    instance.get('/profile'),
    instance.get('/me'),
  ]);
  profile.data.email = me.data.email;
  return profile.data;
};

export const updateProfile = async ({ email, phone }) => {
  if (email && phone) {
    await Promise.all([
      instance.post('/email', { email }),
      instance.post('/phone', { phone }),
    ]);
  }
  if (email) {
    await instance.post('/email', { email });
  }
  if (phone) {
    await instance.post('/phone', { phone });
  }
  return { ok: true };
};

// Order page

export const preorder = async (order) => {
  await dbConnect();

  const user = await User.findOne({ student_id: id });

  user.meals.push(...order);

  await user.save();

  return { ok: true };
};

export const getOrderList = async () => {
  await dbConnect();

  const now = new Date();

  const userHasPreorderedThisMonth = await User.aggregate([
    { $match: { student_id: id } },
    { $project: { 'meals.date': 1, 'meals.dish_id': 1 } },
    {
      $project: {
        meals: {
          $filter: {
            input: '$meals',
            as: 'meal',
            cond: {
              $and: [
                {
                  $gte: [
                    '$$meal.date',
                    new Date(
                      now.getFullYear(),
                      now.getMonth(),
                      now.getDate() + 2,
                    ),
                  ],
                },
                {
                  $lte: [
                    '$$meal.date',
                    new Date(now.getFullYear(), now.getMonth() + 1, 0),
                  ],
                },
              ],
            },
            limit: 1,
          },
        },
      },
    },
  ])
    .exec()
    .then((data) => {
      if (typeof data[0]?.meals[0]?.dish_id !== 'undefined') {
        return true;
      }

      return false;
    });
  if (userHasPreorderedThisMonth) {
    const userHasPreorderedNextMonth = await User.aggregate([
      { $match: { student_id: id } },
      { $project: { 'meals.date': 1, 'meals.dish_id': 1 } },
      {
        $project: {
          meals: {
            $filter: {
              input: '$meals',
              as: 'meal',
              cond: {
                $and: [
                  {
                    $gte: [
                      '$$meal.date',
                      new Date(now.getFullYear(), now.getMonth() + 1, 1),
                    ],
                  },
                  {
                    $lte: [
                      '$$meal.date',
                      new Date(now.getFullYear(), now.getMonth() + 2, 0),
                    ],
                  },
                ],
              },
              limit: 1,
            },
          },
        },
      },
    ])
      .exec()
      .then((data) => {
        if (typeof data[0]?.meals[0]?.dish_id !== 'undefined') {
          return true;
        }

        return false;
      });
    if (userHasPreorderedNextMonth) {
      return [];
    } else {
      const orderList = await Meal.aggregate([
        { $project: { _id: 0, date: 1, dish_ids: 1 } },
        {
          $match: {
            date: {
              $gte: new Date(now.getFullYear(), now.getMonth() + 1, 1),
              $lte: new Date(now.getFullYear(), now.getMonth() + 2, 0),
            },
          },
        },
      ]);

      return orderList;
    }
  } else {
    const orderList = await Meal.aggregate([
      { $project: { _id: 0, date: 1, dish_ids: 1 } },
      {
        $match: {
          date: {
            $gte: new Date(
              now.getFullYear(),
              now.getMonth(),
              now.getDate(), //+2
            ),
            $lte: new Date(now.getFullYear(), now.getMonth() + 2, 0),
          },
        },
      },
    ]);

    return orderList;
  }
};

// Home page

export const createFeedback = async (data) => {
  await dbConnect();
  await Feedback.create({
    student_id: id,
    ...data,
  });
  return { ok: true };
};

export const sendedFeedback = async () => {
  await dbConnect();
  return await Feedback.find({
    student_id: id,
    date: new Date(
      new Date().getFullYear(),
      new Date().getMonth(),
      new Date().getDate(),
    ),
  }).then((data) => (data[0] ? true : false));
};
export const updateMeals = async (updateList) => {
  await dbConnect();

  const user = await User.findOne({ student_id: id });

  updateList.forEach((e) => {
    user.meals[
      recursiveBinarySearch(user.meals, e, 0, user.meals.length - 1)
    ].dish_id = e.dish_id;
  });

  await user.save();

  return { ok: true };
};

function recursiveBinarySearch(arr, x, start, end) {
  if (start > end) return false;

  const mid = Math.floor((start + end) / 2);

  if (
    arr[mid].date.getDate() === x.date.getDate() &&
    arr[mid].date.getMonth() === x.date.getMonth() &&
    arr[mid].date.getFullYear() === x.date.getFullYear()
  )
    return mid;

  if (arr[mid].date > x.date)
    return recursiveBinarySearch(arr, x, start, mid - 1);
  else return recursiveBinarySearch(arr, x, mid + 1, end);
}

const getMealSelection = async () => {
  const selection = await Meal.find({})
    .exec()
    .then((data) => {
      const selection = {};

      data?.forEach((e) => {
        selection[
          `${e.date.getFullYear()}/${e.date.getMonth() + 1}/${e.date.getDate()}`
        ] = e.dish_ids;
      });

      return selection;
    });

  return selection;
};

const getMeals = async () => {
  const meals = await User.aggregate([
    { $match: { student_id: id } },
    { $project: { 'meals.date': 1, 'meals.dish_id': 1 } },
  ])
    .limit(1)
    .exec()
    .then((data) => {
      const meals = {};

      if (data[0]) {
        data[0].meals.forEach((e) => {
          meals[
            `${e.date.getFullYear()}/${e.date.getMonth() + 1}/${e.date.getDate()}`
          ] = e.dish_id;
        });
      }

      return meals;
    });

  return meals;
};

export const getMealsWithSelection = async () => {
  await dbConnect();

  const [meals, selection] = await Promise.all([
    getMeals(),
    getMealSelection(),
  ]);

  return { meals, selection };
};

// Verify page
import { transporter, mailOptions } from '../mailer';
import { redirect } from 'next/navigation';
import { SignJWT } from 'jose';

export const sendOTP = async () => {
  await dbConnect();
  const doc = await Otp.find({ student_id: id });
  const count = doc.length;
  if (count) {
    console.log(new Date() - new Date(doc[0].expireAt));
    if (new Date() - new Date(doc[0].expireAt) < 30 * 1000) {
      return { ok: true };
    }
    await Otp.deleteOne({ student_id: id });
  }
  const OTP = Math.floor(100000 + Math.random() * 900000);
  return instance
    .get('/me')
    .then(({ data }) => data.email)
    .then((email) => {
      return transporter.sendMail({
        ...mailOptions,
        to: email,
        subject: `${OTP} is your verified code`,
        text: 'Hi! Tks your school for has chosen our service as a means of managing u guys🤗. We would try our best to provide u guys as best experiences as we could😉',
        html: `<div>
                <p>Your verification code is: <strong>${OTP}</strong></p>
                <p>Please fill out the code within 1 hour, Tks<3</p>
              </div>`,
      });
    })
    .then(async () => {
      const newOtp = new Otp({
        student_id: id,
        code: OTP,
        expireAt: new Date(),
      });
      await newOtp.save();
      return { ok: true };
    });
};

export const verifyOTP = async ({ otp }) => {
  await dbConnect();
  const doc = await Otp.findOne({ student_id: id });
  if (doc.code == otp) {
    const token = await new SignJWT()
      .setProtectedHeader({ alg: 'HS256' })
      .setExpirationTime(Math.floor(Date.now() / 1000) + 60 * 60)
      .setSubject(id)
      .setIssuer(process.env.JWT_ISSUER)
      .sign(new TextEncoder().encode(process.env.JWT_SECRET));

    redirect(`/reset_password?key=${token}`);
  }
  return {};
};

// Reset Password page

export const resetPass = (pass) => {
  return instance
    .post('/pass', pass)
    .then(() => {
      return { ok: true };
    })
    .catch(() => {
      return { ok: false, message: 'Error changing password' };
    });
};

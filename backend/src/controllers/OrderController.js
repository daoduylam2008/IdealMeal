const User = require("../models/User");
const Meal = require("../models/Meal");

class OrderController {
  async create(req, res) {
    await Meal.insertMany(req.body.meals);
    res.json({ ok: true });
  }
  async show(req, res) {
    const now = new Date();
    const id = Number.parseInt(req.query.id);
    const userHasPreorderedThisMonth = await User.aggregate([
      { $match: { student_id: id } },
      { $project: { "meals.date": 1, "meals.dish_id": 1 } },
      {
        $project: {
          meals: {
            $filter: {
              input: "$meals",
              as: "meal",
              cond: {
                $and: [
                  {
                    $gte: [
                      "$$meal.date",
                      new Date(
                        now.getFullYear(),
                        now.getMonth(),
                        now.getDate() + 2
                      ),
                    ],
                  },
                  {
                    $lte: [
                      "$$meal.date",
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
        if (typeof data[0]?.meals[0]?.dish_id !== "undefined") {
          return true;
        }

        return false;
      });
    if (userHasPreorderedThisMonth) {
      const userHasPreorderedNextMonth = await User.aggregate([
        { $match: { student_id: id } },
        { $project: { "meals.date": 1, "meals.dish_id": 1 } },
        {
          $project: {
            meals: {
              $filter: {
                input: "$meals",
                as: "meal",
                cond: {
                  $and: [
                    {
                      $gte: [
                        "$$meal.date",
                        new Date(now.getFullYear(), now.getMonth() + 1, 1),
                      ],
                    },
                    {
                      $lte: [
                        "$$meal.date",
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
          if (typeof data[0]?.meals[0]?.dish_id !== "undefined") {
            return true;
          }

          return false;
        });
      if (userHasPreorderedNextMonth) {
        return res.json([]);
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

        return res.json(orderList);
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
                now.getDate() + 2
              ),
              $lte: new Date(now.getFullYear(), now.getMonth() + 2, 0),
            },
          },
        },
      ]);

      return res.json(orderList);
    }
  }
  async preorder(req, res) {
    const id = Number.parseInt(req.query.id);
    const user = await User.findOne({ student_id: id });

    user.meals.push(...order);

    await user.save();
  }
}

module.exports = new OrderController();

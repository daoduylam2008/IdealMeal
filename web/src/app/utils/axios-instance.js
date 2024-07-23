'use server';
import axios from 'axios';
import { cookies } from 'next/headers';
import { decodeJwt } from 'jose';
import dayjs from 'dayjs';
const baseURL = process.env.SERVER_URL;
const instance = axios.create({
  baseURL,
});

instance.interceptors.request.use(async (req) => {
  try {
    const token = cookies().get('token').value;
    const isExpired = dayjs.unix(decodeJwt(token).exp).diff(dayjs()) < 1;
    if (isExpired) {
      console.info('path: ', req.url);
      console.info('isExpired: ', isExpired);
      while (isExpired) {}
      // const newToken = await axios.post(
      //   `${baseURL}/refresh`,
      //   {},
      //   {
      //     headers: {
      //       Authorization: `Bearer ${token}`,
      //     },
      //   },
      // );

      // const refreshToken = {
      //   name: 'token',
      //   value: newToken.data.access_token,
      //   path: '/',
      //   secure: true,
      //   httpOnly: true,
      //   sameSite: 'strict',
      //   expires: new Date(
      //     newToken.data.expires_in * 1000 + 60 * 60 * 24 * 7 * 1000,
      //   ),
      // };

      // cookies().set(refreshToken);

      // req.headers.Authorization = `Bearer ${newToken.data.access_token}`;
      // return req;
    }

    // while (isExpired) {
    //   token = cookies().get('token').value;
    //   isExpired = dayjs.unix(decodeJwt(token).exp).diff(dayjs()) < 1;
    // }
    req.headers.Authorization = `Bearer ${token}`;
    return req;
  } catch (error) {
    return Promise.reject(error);
  }
});

export default instance;

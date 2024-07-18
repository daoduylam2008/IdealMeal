'use server';
import axios from 'axios';
import instance from '../axios-instance';
import { cookies } from 'next/headers';
import { redirect } from 'next/navigation';

export const login = ({ req }) => {
  const baseURL = process.env.SERVER_URL
  return axios
    .post(`${baseURL}/login`, req)
    .then((res) => {
      if (res.data) {
        cookies().set({
          name: 'token',
          value: res.data.access_token,
          path: '/',
          secure: true,
          httpOnly: true,
          sameSite: 'strict',
          expires: new Date(
            res.data.expires_in * 1000 + 60 * 60 * 24 * 7 * 1000,
          ),
        });
        return { ok: true };
      }
    })
    .catch((err) => {
      if (typeof err.response?.data.error !== 'undefined') {
        return {
          ok: false,
          message: err.response.data.error,
          status: err.response.status,
        };
      }
      return {
        ok: false,
        message: 'Database Error: Fail to look up account',
        status: 503,
      };
    });
};

export const logout = async () => {
  await instance.post('/logout');
  cookies().delete('token');
  redirect('/');
};

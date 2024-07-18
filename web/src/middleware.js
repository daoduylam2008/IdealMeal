import axios from 'axios';
import dayjs from 'dayjs';
import { cookies } from 'next/headers';
import { NextResponse } from 'next/server';
import { jwtVerify, decodeJwt } from 'jose';
import {
  ResponseCookies,
  RequestCookies,
} from 'next/dist/server/web/spec-extension/cookies';

/**
 * Copy cookies from the Set-Cookie header of the response to the Cookie header of the request,
 * so that it will appear to SSR/RSC as if the user already has the new cookies.
 */
function applySetCookie(req, res) {
  // parse the outgoing Set-Cookie header
  const setCookies = new ResponseCookies(res.headers);
  // Build a new Cookie header for the request by adding the setCookies
  const newReqHeaders = new Headers(req.headers);
  const newReqCookies = new RequestCookies(newReqHeaders);
  setCookies.getAll().forEach((cookie) => newReqCookies.set(cookie));
  // set “request header overrides” on the outgoing response
  NextResponse.next({
    request: { headers: newReqHeaders },
  }).headers.forEach((value, key) => {
    if (
      key === 'x-middleware-override-headers' ||
      key.startsWith('x-middleware-request-')
    ) {
      res.headers.set(key, value);
    }
  });
}

async function middleware(req) {
  const path = req.nextUrl.pathname;
  const token = cookies().get('token');
  const baseURL = process.env.SERVER_URL;

  try {
    const isExpired = dayjs.unix(decodeJwt(token.value).exp).diff(dayjs()) < 1;
    if (isExpired) {
      const newToken = await axios.post(
        `${baseURL}/refresh`,
        {},
        {
          headers: {
            Authorization: `Bearer ${token.value}`,
          },
        },
      );

      const refreshToken = {
        name: 'token',
        value: newToken.data.access_token,
        path: '/',
        secure: true,
        httpOnly: true,
        sameSite: 'strict',
        expires: new Date(
          newToken.data.expires_in * 1000 + 60 * 60 * 24 * 7 * 1000,
        ),
      };
      if (path === '/reset_password') {
        const key = req.nextUrl.searchParams.get('key');
        const secret = new TextEncoder().encode(process.env.JWT_SECRET);
        try {
          const { payload } = await jwtVerify(key, secret, {
            issuer: process.env.JWT_ISSUER,
          });
          if (decodeJwt(token.value).sub != payload.sub)
            throw new Error('Cook');

          const res = NextResponse.next();
          res.cookies.set(refreshToken);
          applySetCookie(req, res);

          return res;
        } catch (e) {
          const res = NextResponse.redirect(
            new URL('/home', req.url).toString(),
          );
          res.cookies.set(refreshToken);
          applySetCookie(req, res);

          return res;
        }
      }

      if (
        path === '/home' ||
        path === '/profile' ||
        path === '/order' ||
        path === '/verify'
      ) {
        const res = NextResponse.next();
        res.cookies.set(refreshToken);
        applySetCookie(req, res);
        return res;
      }

      const res = NextResponse.redirect(new URL('/home', req.url).toString());
      res.cookies.set(refreshToken);
      applySetCookie(req, res);
      return res;
    }

    const res = await axios.get(`${baseURL}/profile`, {
      headers: {
        Authorization: `Bearer ${token.value}`,
      },
    });

    if (dayjs.unix(decodeJwt(token.value).exp).diff(dayjs()) < 1) {
      const newToken = await axios.post(
        `${baseURL}/refresh`,
        {},
        {
          headers: {
            Authorization: `Bearer ${token.value}`,
          },
        },
      );

      const refreshToken = {
        name: 'token',
        value: newToken.data.access_token,
        path: '/',
        secure: true,
        httpOnly: true,
        sameSite: 'strict',
        expires: new Date(
          newToken.data.expires_in * 1000 + 60 * 60 * 24 * 7 * 1000,
        ),
      };
      if (path === '/reset_password') {
        const key = req.nextUrl.searchParams.get('key');
        const secret = new TextEncoder().encode(process.env.JWT_SECRET);
        try {
          const { payload } = await jwtVerify(key, secret, {
            issuer: process.env.JWT_ISSUER,
          });
          if (decodeJwt(token.value).sub != payload.sub)
            throw new Error('Cook');

          const res = NextResponse.next();
          res.cookies.set(refreshToken);
          applySetCookie(req, res);

          return res;
        } catch (e) {
          const res = NextResponse.redirect(
            new URL('/home', req.url).toString(),
          );
          res.cookies.set(refreshToken);
          applySetCookie(req, res);

          return res;
        }
      }

      if (
        path === '/home' ||
        path === '/profile' ||
        path === '/order' ||
        path === '/verify'
      ) {
        const res = NextResponse.next();
        res.cookies.set(refreshToken);
        applySetCookie(req, res);
        return res;
      }

      const res = NextResponse.redirect(new URL('/home', req.url).toString());
      res.cookies.set(refreshToken);
      applySetCookie(req, res);
      return res;
    }

    if (res.data.msg === 'Unknown user') throw new Error('Unauthorized');
    if (path === '/reset_password') {
      const key = req.nextUrl.searchParams.get('key');
      const secret = new TextEncoder().encode(process.env.JWT_SECRET);
      try {
        const { payload } = await jwtVerify(key, secret, {
          issuer: process.env.JWT_ISSUER,
        });
        if (decodeJwt(token.value).sub != payload.sub) throw new Error('Cook');
        return NextResponse.next();
      } catch (e) {
        return NextResponse.redirect(new URL('/home', req.url).toString());
      }
    }
    if (
      path === '/home' ||
      path === '/profile' ||
      path === '/order' ||
      path === '/verify'
    ) {
      return NextResponse.next();
    } else {
      return NextResponse.redirect(new URL('/home', req.url).toString());
    }
  } catch (err) {
    if (path === '/') {
      return NextResponse.next();
    } else {
      return NextResponse.redirect(new URL('/', req.url).toString());
    }
  }
}

export const config = {
  matcher: ['/', '/home', '/profile', '/order', '/verify', '/reset_password'],
};
export default middleware;

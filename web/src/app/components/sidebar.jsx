'use client';
import Link from 'next/link';
import ThemeDialog from './theme';
import { logout } from '../utils/controllers/auth';
import { useState } from 'react';
import { usePathname } from 'next/navigation';
import {
  Hr,
  Home,
  Theme,
  Order,
  Logout,
  Profile,
  Indicator,
  DropDownArrow,
} from './icons';

import clsx from 'clsx';

export default function SideBar({
  children,
  isExpand,
  isTabletExpand,
  setIsTabletExpand,
}) {
  // useEffect(() => {
  //   if (typeof window !== 'undefined') {
  //     window.addEventListener('resize', () => {
  //       const isLargeScreen = window.matchMedia(
  //         '(min-width: 1024px) and (orientation: landscape)',
  //       ).matches;
  //       if (isExpand & !isLargeScreen) {
  //         setIsExpand(false);
  //       }
  //       // if (!isExpand & isLargeScreen) {
  //       //   setIsExpand(true);
  //       // }
  //     });
  //   }
  // }, []);

  const [isThemeSelectionOpen, setIsThemeSelectionOpen] = useState(false);
  const handleExpandThemeMenu = () => {
    setIsThemeSelectionOpen((prev) => !prev);
  };

  const Icons = [
    { href: '/home', src: '/home.svg', alt: 'Home', component: Home },
    { href: '/order', src: '/order.svg', alt: 'Order', component: Order },
    {
      href: '/profile',
      src: '/profile.svg',
      alt: 'Profile',
      component: Profile,
    },
  ];
  const pathname = usePathname();

  return (
    <div className="flex h-full flex-row overflow-hidden max-sm:flex-col-reverse">
      <div
        className={
          'pointer-events-none fixed z-20 h-full w-full transition-[backdrop-filter,-webkit-backdrop-filter] duration-300 max-sm:hidden ' +
          `${isTabletExpand && 'pointer-events-auto backdrop-brightness-75'}`
        }
        onClick={() => setIsTabletExpand(false)}
      ></div>
      <nav
        className={
          'fixed bottom-0 left-0 z-20 flex w-14 flex-col border-r-2 border-border bg-back transition-[border-color,width,padding-top,background-color] duration-300 max-sm:h-12 max-sm:w-full max-sm:flex-row max-sm:justify-around max-sm:border-r-0 max-sm:border-t-2 sm:top-14 ' +
          `${isExpand && 'lg:landscape:w-64 lg:landscape:pt-4'} ${isTabletExpand && 'sm:w-64 sm:pt-4'}`
        }
        // style={{
        //   transition:
        //     'transition: all 300ms cubic-bezier(0.4, 0, 0.2, 1), border-right-width: 0s;',
        // }}
      >
        {Icons.map((Icon) => (
          <Link
            href={Icon.href}
            key={Icon.alt}
            title={Icon.alt}
            onClick={() => setIsTabletExpand(false)}
            className={
              `flex h-14 items-stretch justify-stretch px-3 transition-[padding] duration-300 max-sm:h-[calc(3rem-2px)] max-sm:flex-1 ` +
              `${isExpand && 'lg:landscape:px-5'} ${isTabletExpand && 'sm:px-5'}`
            }
          >
            <div
              className={
                `hover-icon my-1 flex flex-1 items-center overflow-hidden rounded-xl transition-[background-color] duration-300 max-sm:justify-center ` +
                `${isExpand & (pathname === Icon.href) && 'lg:landscape:bg-light'} ${isTabletExpand & (pathname === Icon.href) && 'sm:bg-light'} ` +
                `${isExpand && 'hover:lg:landscape:bg-light'} ${isTabletExpand && 'hover:sm:bg-light'}`
              }
            >
              <div
                className={
                  `mx-1 flex w-auto items-center justify-center transition-[margin] duration-300 ` +
                  `${isExpand && 'lg:landscape:!mx-3'} ${isTabletExpand && 'sm:!mx-3'}`
                }
              >
                <Icon.component
                  className={
                    `transition-[stroke,stroke-width] duration-300 ${pathname === Icon.href ? 'stroke-main' : 'stroke-dark'} ` +
                    `${isExpand && 'lg:landscape:!stroke-main lg:landscape:!stroke-2'} ${isTabletExpand && 'sm:!stroke-main sm:!stroke-2'}`
                  }
                />
              </div>
              <span className={`h2 ml-1 font-semibold max-sm:hidden`}>
                {Icon.alt}
              </span>
            </div>
          </Link>
        ))}
        <div
          className={
            `flex flex-1 flex-col justify-end max-sm:hidden ` +
            `${isExpand && 'lg:landscape:justify-start'} ${isTabletExpand && 'sm:justify-start'}`
          }
        >
          <div
            className={
              `invisible px-7 py-4 ` +
              `${isExpand && 'lg:landscape:visible'} ${isTabletExpand && 'sm:visible'}`
            }
          >
            <Hr />
          </div>
          <div
            className={
              `relative flex h-14 items-stretch justify-stretch px-3 transition-[padding] duration-300 max-sm:h-[calc(3rem-2px)] max-sm:flex-1 ` +
              `${isExpand && 'lg:landscape:px-5'} ${isTabletExpand && 'sm:px-5'}`
            }
          >
            <div
              className={
                `my-1 flex flex-1 cursor-pointer items-center justify-between overflow-hidden rounded-xl transition-[background-color] duration-300 max-sm:justify-center ` +
                `${isExpand && 'hover:lg:landscape:bg-light'} ${isTabletExpand && 'hover:sm:bg-light'}`
              }
              onClick={handleExpandThemeMenu}
            >
              <div className={`flex justify-between`}>
                <div
                  className={
                    `mx-1 flex w-auto items-center justify-center transition-[margin] duration-300 ` +
                    `${isExpand && 'lg:landscape:!mx-3'} ${isTabletExpand && 'sm:!mx-3'}`
                  }
                >
                  <Theme
                    className={
                      `stroke-main transition-[stroke-width] duration-300 ` +
                      `${isExpand && 'lg:landscape:!stroke-2'} ${isTabletExpand && 'sm:!stroke-2'}`
                    }
                  />
                </div>
                <span className={`h2 ml-1 font-semibold max-sm:hidden`}>
                  Theme
                </span>
              </div>
              <div
                className={
                  `flex h-6 w-6 items-center justify-center transition-[margin,transform] duration-300 ` +
                  `${isExpand && `lg:landscape:!mx-12 ${isThemeSelectionOpen && 'lg:landscape:rotate-180'}`} ${isTabletExpand && `sm:!mx-12 ${isThemeSelectionOpen && 'sm:rotate-180'}`}`
                }
              >
                <DropDownArrow />
              </div>
            </div>
            <div
              className={
                `invisible absolute bottom-0 left-full ` +
                `${isThemeSelectionOpen && '!visible'} ${isExpand && 'lg:landscape:bottom-auto lg:landscape:top-0'} ${isTabletExpand && 'sm:bottom-auto sm:top-0'}`
              }
            >
              <ThemeDialog
                isThemeSelectionOpen={isThemeSelectionOpen}
                handleExpandThemeMenu={handleExpandThemeMenu}
              />
            </div>
          </div>
          <div
            className={
              `flex h-14 items-stretch justify-stretch px-3 transition-[padding] duration-300 max-sm:h-[calc(3rem-2px)] max-sm:flex-1 ` +
              `${isExpand && 'lg:landscape:px-5'} ${isTabletExpand && 'sm:px-5'}`
            }
          >
            <div
              className={
                `hover-icon my-1 flex flex-1 cursor-pointer items-center overflow-hidden rounded-xl transition-[background-color] duration-300 max-sm:justify-center ` +
                `${isExpand && 'hover:lg:landscape:bg-light'} ${isTabletExpand && 'hover:sm:bg-light'}`
              }
              onClick={() => logout()}
            >
              <div
                className={
                  `mx-1 flex w-auto items-center justify-center transition-[margin] duration-300 ` +
                  `${isExpand && 'lg:landscape:!mx-3'} ${isTabletExpand && 'sm:!mx-3'}`
                }
              >
                <Logout
                  className={
                    `stroke-main transition-[stroke-width] duration-300 ` +
                    `${isExpand && 'lg:landscape:!stroke-2'} ${isTabletExpand && 'sm:!stroke-2'}`
                  }
                />
              </div>
              <span className={`h2 ml-1 font-semibold max-sm:hidden`}>
                Logout
              </span>
            </div>
          </div>
        </div>
        <Indicator
          className={clsx(
            'absolute transition-transform duration-300 max-sm:-translate-x-[calc(1/3*100vw)] max-sm:translate-y-9 max-sm:-rotate-90 sm:translate-y-5',
            {
              'max-sm:-translate-x-[calc(1/3*100vw)] max-sm:translate-y-11 max-sm:-rotate-90 sm:translate-y-5':
                pathname === '/home',
              'max-sm:translate-x-0 max-sm:translate-y-11 max-sm:-rotate-90 sm:translate-y-[4.75rem]':
                pathname === '/order',
              'max-sm:translate-x-[calc(1/3*100vw)] max-sm:translate-y-11 max-sm:-rotate-90 sm:translate-y-[8.2rem]':
                pathname === '/profile',
            },
          )}
        />
      </nav>
      {children}
    </div>
  );
}

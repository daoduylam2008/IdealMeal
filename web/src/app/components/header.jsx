'use client';
import { Menu, Theme } from './icons';
import { useState, useEffect, createContext } from 'react';
import SideBar from './sidebar';
import ThemeDialog from './theme';

export const IsSidebarExpandContext = createContext(true);

function Header({ children, menu }) {
  const [isExpand, setIsExpand] = useState(true);
  const [isTabletExpand, setIsTabletExpand] = useState(false);
  const [isThemeSelectionOpen, setIsThemeSelectionOpen] = useState(false);
  const handleExpandThemeMenu = () => {
    setIsThemeSelectionOpen((prev) => !prev);
  };
  var temp;
  useEffect(() => {
    const htmlElement = document.getElementById('main-content');
    if (htmlElement) {
      function setLeftVar() {
        htmlElement.style.setProperty(
          '--left',
          isExpand &&
            window.innerWidth >= 1024 &&
            window.innerHeight < window.innerWidth
            ? 16
            : window.innerWidth <= 640
              ? 0
              : 3.5,
        );
      }
      function setScrollVar() {
        const percentOfScreenHeightScrolled =
          htmlElement.scrollTop / htmlElement.clientHeight;
        htmlElement.style.setProperty(
          '--scroll',
          Math.min(percentOfScreenHeightScrolled * 100, 100),
        );
        const indicator = document.getElementById('indicator');
        if (indicator) {
          if (htmlElement.offsetWidth === temp) {
            indicator.style.width = `${
              ((percentOfScreenHeightScrolled * htmlElement.clientHeight) /
                (htmlElement.scrollHeight - htmlElement.clientHeight)) *
              htmlElement.offsetWidth
            }px`;
          } else {
            setTimeout(() => {
              indicator.style.width = `${
                ((percentOfScreenHeightScrolled * htmlElement.clientHeight) /
                  (htmlElement.scrollHeight - htmlElement.clientHeight)) *
                htmlElement.offsetWidth
              }px`;
              temp = htmlElement.offsetWidth;
            }, 300);
          }
        }
      }
      htmlElement.addEventListener('scroll', setScrollVar, true);
      window.addEventListener(
        'resize',
        () => {
          setScrollVar();
          setLeftVar();
        },
        true,
      );
      htmlElement.addEventListener(
        'resize',
        () => {
          setScrollVar();
          setLeftVar();
        },
        true,
      );
      setScrollVar();
      setLeftVar();

      return () => {
        htmlElement.removeEventListener('scroll', setScrollVar, true);
        htmlElement.removeEventListener(
          'resize',
          () => {
            setScrollVar();
            setLeftVar();
          },
          true,
        );
        window.removeEventListener(
          'resize',
          () => {
            setScrollVar();
            setLeftVar();
          },
          true,
        );
      };
    }
  });
  // useEffect(() => {
  //   if (typeof window !== 'undefined') {
  //     const isLargeScreen = window.matchMedia(
  //       '(min-width: 1024px) and (orientation: landscape)',
  //     ).matches;
  //     if (isLargeScreen) {
  //       setIsExpand(true);
  //     }
  //   }
  // },[]);
  const handleOpenMenu = () => {
    if (typeof window !== 'undefined') {
      const isTablet = window.matchMedia(
        '(max-width: 1024px) and (min-width: 640px)',
      ).matches;
      if (isTablet) {
        setIsTabletExpand((prev) => !prev);
        if (isExpand) {
          setIsExpand(false);
        }
      } else {
        if (isTabletExpand) {
          setIsTabletExpand(false);
        } else {
          setIsExpand((prev) => !prev);
        }
      }
    }
  };
  return (
    <>
      <header className="fixed top-0 z-20 w-full justify-between bg-back transition-all duration-300">
        {menu ? (
          <>
            <div className="flex items-center">
              <div
                className="flex w-14 items-center justify-center self-stretch max-sm:hidden"
                onClick={handleOpenMenu}
              >
                <Menu />
              </div>
              <h1 className="sm:ml-0">Ideal Meal</h1>
            </div>
            <div
              className="flex w-12 items-center justify-center self-stretch transition-all duration-300 hover:-translate-y-0.5 active:translate-y-0.5 sm:hidden"
              onClick={handleExpandThemeMenu}
            >
              <Theme className={`stroke-main !stroke-2`} />
            </div>
            <div
              className={
                `invisible fixed right-0 top-[calc(3rem-2px)] sm:hidden ` +
                `${isThemeSelectionOpen && '!visible'}`
              }
            >
              <ThemeDialog
                isThemeSelectionOpen={isThemeSelectionOpen}
                handleExpandThemeMenu={handleExpandThemeMenu}
              />
            </div>
          </>
        ) : (
          <h1>Ideal Meal</h1>
        )}
      </header>

      <div className="h-full pt-14 max-sm:pt-12">
        {menu ? (
          <SideBar
            isExpand={isExpand}
            setIsExpand={setIsExpand}
            isTabletExpand={isTabletExpand}
            setIsTabletExpand={setIsTabletExpand}
          >
            <div
              id="main-content"
              className={
                `h-full w-full overflow-x-hidden scroll-smooth transition-all duration-300 max-sm:pb-12 sm:ml-14 ` +
                `${isExpand && 'lg:landscape:!ml-64'}`
              }
            >
              <IsSidebarExpandContext.Provider value={isExpand}>
                {children}
              </IsSidebarExpandContext.Provider>
            </div>
          </SideBar>
        ) : (
          children
        )}
      </div>
    </>
  );
}

export default Header;

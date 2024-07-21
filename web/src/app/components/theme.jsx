'use client';
import { useTheme } from 'next-themes';
import { useState, useEffect } from 'react';
import { Hr } from './icons';

export default function ThemeDialog({
  isThemeSelectionOpen,
  handleExpandThemeMenu,
}) {
  const { theme, setTheme } = useTheme();
  const [mounted, setMounted] = useState(false);
  useEffect(() => setMounted(true));

  const themes = ['dark', 'light'];
  return (
    <div
      className={`z-10 flex max-h-0 w-48 flex-col items-stretch overflow-hidden rounded border-2 border-border bg-back opacity-0 transition-[max-height,opacity] duration-300 ${isThemeSelectionOpen && '!max-h-44 opacity-100'}`}
      onClick={handleExpandThemeMenu}
    >
      {mounted && (
        <>
          <div>
            <div
              className="hover-wrapper flex h-14 items-center justify-center px-5 py-3 transition-[background-color] duration-300 hover:bg-light max-sm:h-12"
              onClick={() => setTheme('system')}
            >
              <span
                className={`p overflow-hidden text-ellipsis whitespace-nowrap ${theme !== 'system' && 'text-dark'}`}
              >
                System
              </span>
            </div>
          </div>

          {themes.map((e) => (
            <div key={e}>
              <div className="px-5">
                <Hr />
              </div>
              <div
                className="hover-wrapper flex h-14 items-center justify-center px-5 py-3 transition-[background-color] duration-300 hover:bg-light max-sm:h-12"
                onClick={() => setTheme(e)}
              >
                <span
                  className={`p overflow-hidden text-ellipsis whitespace-nowrap ${theme !== e && 'text-dark'}`}
                >
                  {e.charAt(0).toUpperCase() + e.slice(1)}
                </span>
              </div>
            </div>
          ))}
        </>
      )}
    </div>
  );
}

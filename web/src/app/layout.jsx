import { Inter } from 'next/font/google';
import './globals.css';
import Provider from './utils/Providers';
import { ThemeProvider } from 'next-themes';

const inter = Inter({ subsets: ['latin'], preload: false });

export const metadata = {
  title: 'Ideal Meal',
  description: 'Ideal Meal',
};

export default function RootLayout({ children }) {
  return (
    <html lang="en" suppressHydrationWarning className="h-full">
      {/* <head>
        <meta name="viewport" content="width=device-width, initial-scale=" />
      </head> */}
      <body
        className={`${inter.className} h-full bg-back transition-colors duration-300`}
      >
        <ThemeProvider attribute="class">
          <Provider>{children}</Provider>
        </ThemeProvider>
      </body>
    </html>
  );
}

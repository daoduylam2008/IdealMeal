/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        border: 'var(--border)',
        light: 'var(--light)',
        dark: 'var(--dark)',
        main: 'var(--main)',
        back: 'var(--back)',
        shadow: 'var(--shadow)',
      },
    },
    // screens: {
    //   xs: '540px',
    //   sm: '640px',
    //   md: '768px',
    //   lg: '1024px',
    // },
  },
  plugins: [],
};

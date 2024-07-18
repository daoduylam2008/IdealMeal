'use client';
import { ArrowButton } from './components/buttons/buttons';
import { LoginModal } from './components/modals/modals';
import Header from './components/header';

export default function Home() {
  const handleOpenLoginModal = () => {
    const loginModal = document.getElementById('login-modal');
    loginModal.showModal();
  };
  return (
    <>
      <Header menu={false}>
        <div className="flex h-full flex-col items-center justify-center">
          <h2 className="font-bold">Welcome to Ideal Meal</h2>
          <p className="mb-5 mt-2 hidden px-10 text-center text-main max-sm:block">
            Your smart lunchtime companion, designed to simplify meal management
            for schools.
          </p>
          <p className="mb-5 mt-2 max-w-5xl px-10 text-center text-main max-sm:hidden">
            Your smart lunchtime companion, designed to simplify meal management
            for schools. With a focus on nutrition and convenience, our app
            ensures that every student enjoys a delicious, balanced meal that
            powers their learning and growth.
          </p>
          <ArrowButton
            handleClick={handleOpenLoginModal}
            content={'Login'}
            className={'!w-32'}
          />
        </div>
      </Header>
      <LoginModal />
    </>
  );
}

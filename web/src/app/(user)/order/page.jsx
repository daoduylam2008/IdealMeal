'use client';

import Image from 'next/image';
import styles from './Order.module.css';

import { Hr, Loader } from '@/app/components/icons';
import { preorder } from '@/app/utils/controllers/actions';
import { getOrderList } from '@/app/utils/controllers/actions';
import { ColorfulButton } from '@/app/components/buttons/buttons';
import { IsSidebarExpandContext } from '@/app/components/header';
import { useEffect, useState, useContext } from 'react';
import { usePreorder } from '@/app/hooks/usePreorder';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';

export default function Order() {
  const mealQuery = useQuery({
    queryKey: ['order'],
    queryFn: () => getOrderList(),
  });
  return mealQuery.isLoading ? (
    <div className="flex min-h-full flex-1 flex-col items-center space-y-5 bg-back px-5 py-10 transition-all duration-300 sm:space-y-10">
      <Loader />
    </div>
  ) : mealQuery.data[0] ? (
    <Preorder meals={mealQuery.data} />
  ) : (
    <Main hasPreorder={false} />
  );
}

function Preorder({ meals }) {
  const [error, setError] = useState(null);

  useEffect(() => {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          entry.target.style.opacity = entry.intersectionRatio;
        });
      },
      {
        threshold: [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0],
      },
    );
    const orderItems = document.querySelectorAll('.order-item');
    if (orderItems) {
      orderItems.forEach((e) => {
        observer.observe(e);
      });
    }
    return () => {
      const orderItems = document.querySelectorAll('.order-item');
      if (orderItems) {
        orderItems.forEach((e) => {
          observer.disconnect(e);
        });
      }
    };
  });
  const { order, orderList, setOrderList } = usePreorder(meals, setError);
  // const queryClient = useQueryClient();
  // const order = useMutation({
  //   mutationFn: () => {
  //     const preorderForm = [];
  //     for (let i = 0; i < meals.length; i++) {
  //       preorderForm.push({
  //         date: meals[i].date,
  //         dish_id:
  //           orderList[i] === meals[i].dish_ids.length
  //             ? 'Không ăn'
  //             : meals[i].dish_ids[orderList[i]],
  //       });
  //     }
  //     return preorder(preorderForm);
  //   },
  //   onSuccess: () => {
  //     queryClient.invalidateQueries({ queryKey: ['order'] });
  //   },
  //   onError: (err) => {
  //     setError(err);
  //   },
  // });

  const handleOrder = () => {
    Object.keys(orderList).length === meals.length
      ? order.mutate()
      : setError('Complete the form to submit');
  };

  return (
    <div
      id="order"
      className="flex min-h-full flex-col items-stretch bg-back py-10 transition-all duration-300"
    >
      <Main hasPreorder={true} />
      {meals.map((e, i) => {
        return (
          <div
            key={i}
            className="order-item mb-20 flex flex-col items-center px-5"
          >
            <span className="h3 my-3.5 sm:text-2xl">
              {`${e.date.toLocaleString('default', {
                weekday: 'long',
              })}, ${e.date.toLocaleString('default', {
                dateStyle: 'medium',
              })}`}
            </span>
            <div className="choices mx-5 w-[calc(100vw-6rem)] max-w-2xl rounded border-2 border-border transition-all duration-300 max-sm:w-full">
              {e.dish_ids.map((dish, j) => {
                return (
                  <div
                    key={j}
                    onClick={() => {
                      setOrderList((prev) => {
                        const newOrderList = { ...prev, [i]: j };
                        return newOrderList;
                      });
                    }}
                  >
                    <div className="hover-wrapper flex h-14 items-center justify-center transition-all duration-300 hover:bg-light max-sm:h-12 sm:h-16">
                      <span
                        className={`h3 pointer-events-none font-semibold ${typeof orderList[i] === 'undefined' ? 'text-main' : orderList[i] === j ? 'text-main' : '!text-dark'} sm:text-xl`}
                      >
                        {dish}
                      </span>
                    </div>
                    <div className="px-9">
                      <Hr />
                    </div>
                  </div>
                );
              })}
              <div
                className="hover-wrapper flex h-14 items-center justify-center transition-all duration-300 hover:bg-light max-sm:h-12"
                onClick={() => {
                  setOrderList((prev) => {
                    const newOrderList = { ...prev, [i]: e.dish_ids.length };
                    return newOrderList;
                  });
                }}
              >
                <span
                  className={`h3 pointer-events-none font-semibold text-main ${typeof orderList[i] === 'undefined' ? 'text-main' : orderList[i] === e.dish_ids.length ? 'text-main' : '!text-dark'} sm:text-xl`}
                >
                  Không ăn
                </span>
              </div>
            </div>
          </div>
        );
      })}
      <div className="flex w-[calc(100vw-6rem)] max-w-2xl flex-col items-stretch justify-start self-center max-sm:w-full max-sm:px-5">
        <div className="flex flex-col items-stretch" onClick={handleOrder}>
          <ColorfulButton content={'Submit'} />
        </div>

        <div className="-mt-8">
          <p className="!text-red-600">{error}</p>
        </div>
      </div>
    </div>
  );
}

function Main({ hasPreorder }) {
  let x = 0;
  let y = 0;
  let lFollowX = 0;
  let lFollowY = 0;
  let frame;
  const isExpand = useContext(IsSidebarExpandContext);
  useEffect(() => {
    function handleMovement() {
      x += (lFollowX - x) / 30;
      y += (lFollowY - y) / 30;

      const gradient = document.querySelector('.gradient');
      if (gradient) {
        gradient.style.transform = hasPreorder
          ? `translateX(${x}px) translateY(calc(${y - 60}px + 1px * (var(--scroll) * 5)))`
          : `translateX(${x}px) translateY(${y}px)`;
      }
      frame = window.requestAnimationFrame(handleMovement);
    }
    handleMovement();
    return () => {
      window.cancelAnimationFrame(frame);
    };
  });
  const handleEffect = (e) => {
    document.querySelectorAll('.gradient').forEach((txt) => {
      if (e.view.innerWidth >= 1024 && e.view.innerWidth > e.view.innerHeight) {
        lFollowX = isExpand
          ? (e.clientX - 256 - (e.view.innerWidth - 256) / 2) / 10
          : (e.clientX - 56 - (e.view.innerWidth - 56) / 2) / 10;
        lFollowY = (e.clientY - 56 - (e.view.innerHeight - 56) / 2) / 10;
        txt.style.transform = `translateX(${x}px) translateY(${y}px)`;
      }
    });
  };

  return (
    <div
      onMouseMove={handleEffect}
      className="flex min-h-full flex-col items-stretch justify-stretch overflow-hidden transition-all duration-300"
    >
      <div
        className={`${styles.bgClip} gradient pointer-events-none relative -ml-[50%] flex w-[200%] flex-1 flex-col items-center justify-center bg-gradient-to-tr from-cyan-500 from-30% to-pink-500 to-70%`}
      >
        <div
          id={`${styles.backdrop}`}
          className="absolute left-0 top-0 z-10 h-full w-full bg-back opacity-0"
        ></div>
        <span className={`${styles.giant}`}>
          {hasPreorder ? 'Preorder' : 'No Preorder'}
        </span>
        <span className={`${styles.giant}`}>
          {hasPreorder ? 'Available!' : 'List Founded'}
        </span>
        <span className="h4 relative my-6 max-sm:text-sm">
          {hasPreorder
            ? '“Scroll down to preorder your dishes \\^o^/”'
            : '“Go to home to change your dishes;)”'}
          <Image
            className={`absolute -bottom-24 -right-28 max-sm:-right-20 max-sm:scale-75 ${styles.gif} ${!hasPreorder && 'hidden'}`}
            src={'/arrow.gif'}
            unoptimized={true}
            alt="arrow-gif"
            width={150}
            height={(150 * 772) / 826}
          />
        </span>
      </div>

      <div
        id="indicator"
        className={`${styles.indicator} fixed bottom-0 left-[calc(var(--left)*1rem)] z-10 h-2 w-0 bg-gradient-to-r from-cyan-500 to-pink-500 transition-[left] duration-300 max-sm:mb-12`}
      ></div>
    </div>
  );
}

'use client';
import styles from './Calendar.module.css';
import TodayModal from '@/app/components/modals/today-modal';
import { useState, useEffect, useContext } from 'react';
import { IsSidebarExpandContext } from '@/app/components/header';
import { useCalendar } from '@/app/hooks/useCalendar';
import { useUpdateMeals } from '@/app/hooks/useUpdateMeals';
import {
  ForwardArrow,
  Modify,
  Hr,
  Cancel,
  Save,
  Loader,
  Qr,
} from '@/app/components/icons';

export default function Home() {
  const now = new Date();

  const [isEdit, setIsEdit] = useState(false);
  const [selectedIndex, setSelectedIndex] = useState(null);
  const [calendar, time, setTime, todayDish] = useCalendar();
  const [order, orderList, setOrderList, optimisticDates] =
    useUpdateMeals(setIsEdit);
  const isExpand = useContext(IsSidebarExpandContext);
  const handleOpenTodayModal = () => {
    const todayModal = document.getElementById('today-modal');
    todayModal.showModal();
  };

  const toggleEdit = () => {
    if (isEdit) {
      setSelectedIndex(null);
    }
    setIsEdit((prev) => !prev);
  };

  const handleUpdateMeal = () => {
    const dates = Object.keys(orderList);
    if (dates.length !== 0) {
      order.mutate(dates);
    } else {
      setIsEdit(false);
    }
  };

  return (
    <div className="flex h-full flex-col lg:landscape:flex-row">
      {todayDish.dish_id && todayDish.dish_id !== 'Không ăn' && (
        <div
          className={`hidden flex-row border-b-2 max-sm:flex`}
          onClick={todayDish.dish_id && handleOpenTodayModal}
        >
          <div className="h-28 flex-1 overflow-hidden border-r-2 px-4 py-3 transition-[border-color] duration-300">
            <p>Date</p>
            <div className="flex flex-nowrap">
              <span className="h3 overflow-hidden text-ellipsis whitespace-nowrap">
                {`${new Date().getFullYear()}/${new Date().getMonth() + 1}/${new Date().getDate()}`}
              </span>
            </div>

            <p>Your set</p>
            <div className="flex flex-nowrap">
              <span className="h3 overflow-hidden text-ellipsis whitespace-nowrap">
                {todayDish.dish_id || 'Không ăn'}
              </span>
            </div>
          </div>

          <div className="flex h-28 w-auto flex-row-reverse">
            <header className="h-auto w-12 items-center justify-center border-b-0 border-l-2">
              <h2 className="m-0 [writing-mode:vertical-lr]">Qrcode</h2>
            </header>

            <div className="flex w-28 flex-1 scale-90 items-center justify-center p-3">
              <Qr />
            </div>
          </div>
        </div>
      )}

      <div className={`flex flex-1 flex-col items-stretch`}>
        <div>
          <div
            className={`flex h-14 items-center justify-between border-b-2 transition-[border-color] duration-300 max-sm:h-12`}
          >
            <div className="flex items-center">
              <div
                className="flex h-[calc(3.5rem-2px)] w-[calc(3.5rem-2px)] rotate-180 items-center justify-center transition-transform duration-300 hover:scale-125 max-sm:h-[calc(3rem-2px)] max-sm:w-[calc(3rem-2px)] lg:landscape:hidden"
                onClick={() => {
                  setSelectedIndex(null);
                  setTime(
                    (prev) =>
                      new Date(prev.getFullYear(), prev.getMonth() - 1, 15),
                  );
                }}
              >
                <ForwardArrow />
              </div>
              <h2 className="w-48 text-center max-sm:w-40 lg:landscape:ml-3 lg:landscape:text-left">
                {time.toLocaleString('default', {
                  month: 'long',
                  year: 'numeric',
                })}
              </h2>
              <div
                className="hidden h-[calc(3.5rem-2px)] w-[calc(3.5rem-2px)] rotate-180 items-center justify-center transition-transform duration-300 hover:scale-125 max-sm:h-[calc(3rem-2px)] max-sm:w-[calc(3rem-2px)] lg:landscape:flex"
                onClick={() => {
                  setSelectedIndex(null);
                  setTime(
                    (prev) =>
                      new Date(prev.getFullYear(), prev.getMonth() - 1, 15),
                  );
                }}
              >
                <ForwardArrow />
              </div>
              <div
                className="flex h-[calc(3.5rem-2px)] w-[calc(3.5rem-2px)] items-center justify-center transition-transform duration-300 hover:scale-125 max-sm:h-[calc(3rem-2px)] max-sm:w-[calc(3rem-2px)]"
                onClick={() => {
                  setSelectedIndex(null);
                  setTime(
                    (prev) =>
                      new Date(prev.getFullYear(), prev.getMonth() + 1, 15),
                  );
                }}
              >
                <ForwardArrow />
              </div>
            </div>
            {order.isPending ? (
              <div
                className="flex h-[calc(3.5rem-2px)] w-[calc(3.5rem-2px)] items-center justify-center max-sm:h-[calc(3rem-2px)] max-sm:w-[calc(3rem-2px)]"
                onClick={handleUpdateMeal}
              >
                <Loader />
              </div>
            ) : isEdit ? (
              <div className="flex">
                <div
                  className="flex h-[calc(3.5rem-2px)] w-[calc(3.5rem-2px)] items-center justify-center transition-transform duration-300 hover:-translate-y-0.5 active:translate-y-0.5 max-sm:h-[calc(3rem-2px)] max-sm:w-[calc(3rem-2px)]"
                  onClick={handleUpdateMeal}
                >
                  <Save />
                </div>

                <div
                  className="flex h-[calc(3.5rem-2px)] w-[calc(3.5rem-2px)] items-center justify-center transition-transform duration-300 hover:-translate-y-0.5 active:translate-y-0.5 max-sm:h-[calc(3rem-2px)] max-sm:w-[calc(3rem-2px)]"
                  onClick={() => toggleEdit()}
                >
                  <Cancel />
                </div>
              </div>
            ) : (
              <div
                className="flex h-[calc(3.5rem-2px)] w-[calc(3.5rem-2px)] items-center justify-center transition-transform duration-300 hover:-translate-y-0.5 active:translate-y-0.5 max-sm:h-[calc(3rem-2px)] max-sm:w-[calc(3rem-2px)] max-sm:scale-90"
                onClick={() => toggleEdit()}
              >
                <Modify />
              </div>
            )}
          </div>

          <div className="grid h-8 w-full grid-cols-5 grid-rows-1 border-b-2 transition-[border-color] duration-300">
            {['Mon', 'Tue', 'Wed', 'Thu', 'Fri'].map((e, i) => {
              return (
                <div
                  key={e}
                  className={`flex items-center justify-center transition-[border-color] duration-300 ${i % 5 !== 4 && 'border-r-2'}`}
                >
                  <span className="p">{e}</span>
                </div>
              );
            })}
          </div>
        </div>

        <div className="flex w-full flex-1">
          <div
            className={`z-0 grid w-full grid-cols-5 ${calendar.length === 4 ? 'grid-rows-4' : 'grid-rows-5'} min-h-0`}
          >
            {calendar.map((week, weekIndex) =>
              week.map(({ date, isThisMonth, meal, selection }, day) => {
                return (
                  <CalendarBox
                    isNow={
                      now.getFullYear() === date.getFullYear() &&
                      now.getMonth() === date.getMonth() &&
                      now.getDate() === date.getDate()
                    }
                    handleOpenDialog={(e) => {
                      selection &&
                        isEdit &&
                        setSelectedIndex(
                          new Date(
                            new Date(e.target.id).getFullYear(),
                            new Date(e.target.id).getMonth(),
                            new Date(e.target.id).getDate(),
                          ) >=
                            new Date(
                              now.getFullYear(),
                              now.getMonth(),
                              now.getDate() + 2,
                            ) && date.toString() !== selectedIndex
                            ? e.target.id
                            : null,
                        );
                    }}
                    day={day}
                    key={date}
                    date={date}
                    meal={meal}
                    isEdit={isEdit}
                    orderList={orderList}
                    selection={selection}
                    weekIndex={weekIndex}
                    isThisMonth={isThisMonth}
                    setOrderList={setOrderList}
                    lastWeekIndex={calendar.length - 1}
                    optimisticDates={optimisticDates}
                    handleOpenTodayModal={handleOpenTodayModal}
                    showDialog={date.toString() === selectedIndex}
                  />
                );
              }),
            )}
          </div>
        </div>
      </div>
      {todayDish.dish_id && todayDish.dish_id !== 'Không ăn' && (
        <>
          <TodayModal {...todayDish} />
        </>
      )}
    </div>
  );
}

function CalendarBox({
  day,
  date,
  meal,
  isNow,
  isEdit,
  orderList,
  selection,
  weekIndex,
  showDialog,
  isThisMonth,
  setOrderList,
  lastWeekIndex,
  optimisticDates,
  handleOpenDialog,
  handleOpenTodayModal,
}) {
  const [mounted, setMounted] = useState(false);
  useEffect(() => {
    if (!isEdit) {
      setOrderList({});
    }
  }, [isEdit]);
  useEffect(() => {
    setMounted(true);
  });
  return (
    <div
      onClick={
        isNow
          ? meal && meal !== 'Không ăn' && handleOpenTodayModal
          : handleOpenDialog
      }
      className={
        `relative flex flex-col items-stretch justify-between overflow-visible px-2 pb-0.5 pt-1 transition-[box-shadow,border-color] duration-300 hover:shadow-[inset_0px_0px_15px_var(--shadow)] sm:px-3 sm:py-2 ` +
        `${weekIndex !== lastWeekIndex && 'border-b-2'} ${day % 5 !== 4 && 'border-r-2'} ${isNow && `${styles.nowBox}`}`
      }
      id={mounted ? date.toString() : undefined}
    >
      <div className="pointer-events-none flex justify-end">
        <p className={isThisMonth ? 'text-main' : null}>{date.getDate()}</p>
      </div>

      <div className="pointer-events-none mb-1 flex flex-col">
        {meal && (
          <>
            <p>Dish</p>
            <div className="flex flex-nowrap overflow-hidden">
              <span
                className={`p overflow-hidden text-ellipsis whitespace-nowrap ${optimisticDates.includes(date.toString()) | !isThisMonth && '!text-dark'}`}
              >
                {orderList[date.toString()] || meal}
              </span>
            </div>
          </>
        )}
        <div className="absolute right-1 top-1 h-2 w-2 rounded-full"></div>
      </div>
      {showDialog && (
        <CalendarDialog
          isLastWeek={weekIndex === lastWeekIndex}
          day={day}
          selection={selection}
          meal={meal}
          date={date}
          orderList={orderList}
          setOrderList={setOrderList}
        />
      )}
    </div>
  );
}

function CalendarDialog({
  day,
  meal,
  date,
  selection,
  orderList,
  isLastWeek,
  setOrderList,
}) {
  const handleChange = (dish) => {
    if (dish !== meal && dish !== orderList[date.toString()]) {
      setOrderList((prev) => {
        return { ...prev, [date.toString()]: dish };
      });
    } else if (dish === meal) {
      setOrderList((prev) => {
        delete prev[date.toString()];
        return prev;
      });
    }
  };
  // useEffect(() => {
  //   const dialog = document.getElementById('selection-dialog');
  //   dialog.animate([{ opacity: 1 }], {
  //     duration: 300,
  //     easing: 'cubic-bezier(0.4, 0, 0.2, 1)',
  //     fill: 'forwards',
  //   });
  //   return () =>
  //     dialog.animate([{ opacity: 0 }], {
  //       duration: 300,
  //       easing: 'cubic-bezier(0.4, 0, 0.2, 1)',
  //       fill: 'forwards',
  //     });
  // });
  return (
    <div
      id="selection-dialog"
      className={
        `absolute z-10 min-w-48 flex-col items-stretch justify-center rounded border-2 bg-back shadow-sm lg:landscape:w-72 ` +
        `${isLastWeek ? 'bottom-[calc(100%-1.5rem)] sm:bottom-[calc(100%-2rem)]' : `-top-0.5`} ${day % 5 === 3 || day % 5 === 4 ? 'right-full' : `left-full ${day % 5 === 2 ? 'max-sm:-left-1/2' : ''}`} `
      }
    >
      {selection.map((e, i) => (
        <div key={i}>
          <div
            className="hover-wrapper flex items-center overflow-hidden px-5 py-3 hover:bg-light lg:landscape:justify-center"
            onClick={() => handleChange(selection[i])}
          >
            <span
              className={`p overflow-hidden text-ellipsis whitespace-nowrap text-dark ${(orderList[date.toString()] || meal) === e && '!text-main'}`}
            >
              {e}
            </span>
          </div>
          <div className="mx-5">
            <Hr />
          </div>
        </div>
      ))}
      <div
        className="hover-wrapper flex items-center overflow-hidden px-5 py-3 hover:bg-light lg:landscape:justify-center"
        onClick={() => handleChange('Không ăn')}
      >
        <span
          className={`p overflow-hidden text-ellipsis whitespace-nowrap text-dark ${(orderList[date.toString()] || meal) === 'Không ăn' && '!text-main'}`}
        >
          Không ăn
        </span>
      </div>
    </div>
  );
}

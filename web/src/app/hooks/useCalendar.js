'use client';

import { useQuery } from '@tanstack/react-query';
import { useEffect, useState } from 'react';
import { getMealsWithSelection } from '../utils/controllers/actions';

export const useCalendar = () => {
  const initMonth = new Date(
    new Date().getFullYear(),
    new Date().getMonth(),
    15,
  );
  const [time, setTime] = useState(initMonth);
  const [calendar, setCalendar] = useState(
    getCalendar({ meals: {}, selection: {}, date: time }),
  );
  const [todayDish, setTodayDish] = useState({});
  const mealQuery = useQuery({
    queryKey: ['calendar'],
    queryFn: () => getMealsWithSelection(),
  });
  useEffect(() => {
    if (!mealQuery.data) {
      setCalendar(getCalendar({ meals: {}, selection: {}, date: time }));
      setTodayDish({});
    } else {
      setCalendar(
        getCalendar({
          meals: mealQuery.data.meals,
          selection: mealQuery.data.selection,
          date: time,
        }),
      );
      setTodayDish({
        date: new Date(
          new Date().getFullYear(),
          new Date().getMonth(),
          new Date().getDate(),
        ),
        dish_id:
          mealQuery.data.meals[
            `${new Date().getFullYear()}/${new Date().getMonth() + 1}/${new Date().getDate()}`
          ],
      });
    }
  }, [mealQuery.isFetching, time]);
  return [calendar, time, setTime, todayDish];
};

function getCalendar({ meals, selection, date }) {
  const calendar = [];
  let temp = [];
  const lastDay = new Date(date.getFullYear(), date.getMonth() + 1, 0);
  for (let i = 1; i <= lastDay.getDate(); i++) {
    const thisDate = new Date(date.getFullYear(), date.getMonth(), i);
    // Is Friday check
    if (thisDate.getDay() === 5) {
      // Check if first week of month contains 5 days, if not, fill the week with those last days of the previous month
      if (temp.length !== 4) {
        const lastDayOfLastMonth = new Date(
          date.getFullYear(),
          date.getMonth(),
          0,
        ).getDate();
        const start = lastDayOfLastMonth - (4 - temp.length);
        const arrayOfLastDaysOfLastMonth = [];
        for (let j = start; j < lastDayOfLastMonth; j++) {
          const date = new Date(
            thisDate.getFullYear(),
            thisDate.getMonth() - 1,
            j + 1,
          );
          arrayOfLastDaysOfLastMonth.push({
            date,
            isThisMonth: false,
            meal: meals[
              `${date.getFullYear()}/${date.getMonth() + 1}/${date.getDate()}`
            ],
          });
        }
        temp = [...arrayOfLastDaysOfLastMonth, ...temp];
      }
      calendar.push([
        ...temp,
        {
          date: thisDate,
          isThisMonth: true,
          meal: meals[
            `${thisDate.getFullYear()}/${thisDate.getMonth() + 1}/${thisDate.getDate()}`
          ],
          selection:
            selection[
              `${thisDate.getFullYear()}/${thisDate.getMonth() + 1}/${thisDate.getDate()}`
            ],
        },
      ]);
      temp = [];
      // Is last day of month check
    } else if (thisDate.getDate() === lastDay.getDate()) {
      if (thisDate.getDay() !== 0 && thisDate.getDay() !== 6) {
        temp.push({
          date: thisDate,
          isThisMonth: true,
          meal: meals[
            `${thisDate.getFullYear()}/${thisDate.getMonth() + 1}/${thisDate.getDate()}`
          ],
          selection:
            selection[
              `${thisDate.getFullYear()}/${thisDate.getMonth() + 1}/${thisDate.getDate()}`
            ],
        });
      }
      // Check if last week of month contains Friday, if not, fullfill the gaps with those first days of the next month
      if (temp.length !== 0) {
        const range = 5 - temp.length;
        for (let j = 0; j < range; j++) {
          const date = new Date(
            thisDate.getFullYear(),
            thisDate.getMonth() + 1,
            j + 1,
          );
          temp.push({
            date,
            isThisMonth: false,
            meal: meals[
              `${date.getFullYear()}/${date.getMonth() + 1}/${date.getDate()}`
            ],
          });
        }
        calendar.push(temp);
      }
      // Eliminate Saturday and Sunday
    } else if (thisDate.getDay() !== 0 && thisDate.getDay() !== 6) {
      temp.push({
        date: thisDate,
        isThisMonth: true,
        meal: meals[
          `${thisDate.getFullYear()}/${thisDate.getMonth() + 1}/${thisDate.getDate()}`
        ],
        selection:
          selection[
            `${thisDate.getFullYear()}/${thisDate.getMonth() + 1}/${thisDate.getDate()}`
          ],
      });
    }
  }
  return calendar;
}

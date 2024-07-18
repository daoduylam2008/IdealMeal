'use client';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { updateMeals } from '@/app/utils/controllers/actions';
import { useState } from 'react';

export const useUpdateMeals = (setIsEdit) => {
  const queryClient = useQueryClient();
  const [orderList, setOrderList] = useState({});
  const [optimisticDates, setOptimisticDates] = useState([]);
  const order = useMutation({
    mutationFn: (dates) => {
      const preorderForm = [];
      dates.map((key) => {
        preorderForm.push({
          date: new Date(key),
          dish_id: orderList[key],
        });
      });

      return updateMeals(preorderForm);
    },
    onMutate: async (dates) => {
      await queryClient.cancelQueries({ queryKey: ['calendar'] });

      // Snapshot the previous value
      const previousCalendar = queryClient.getQueryData(['calendar']);

      // Optimistically update to the new value
      setOptimisticDates(dates);
      dates.map((key) => {
        queryClient.setQueryData(['calendar'], (old) => {
          return {
            meals: {
              ...old.meals,
              [`${new Date(key).getFullYear()}/${new Date(key).getMonth() + 1}/${new Date(key).getDate()}`]:
                orderList[key],
            },
            selection: old.selection,
          };
        });
      });
      // Return a context object with the snapshotted value
      return { previousCalendar };
    },
    onError: (err, newCalendar, context) => {
      setError(err);
      setOptimisticDates([]);
      queryClient.setQueryData(['calendar'], context.previousCalendar);
    },
    // Always refetch after error or success:
    onSettled: () => {
      setIsEdit(false);
      setOptimisticDates([]);
      queryClient.invalidateQueries({ queryKey: ['calendar'] });
    },
  });
  return [order, orderList, setOrderList, optimisticDates];
};

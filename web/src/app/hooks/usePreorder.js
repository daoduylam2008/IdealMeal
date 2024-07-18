'use client';
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { useState } from 'react';
import { preorder } from '../utils/controllers/actions';

export const usePreorder = (meals, setError) => {
  const queryClient = useQueryClient();
  const [orderList, setOrderList] = useState({});
  
  const order = useMutation({
    mutationFn: () => {
      const preorderForm = [];
      for (let i = 0; i < meals.length; i++) {
        preorderForm.push({
          date: meals[i].date,
          dish_id:
            orderList[i] === meals[i].dish_ids.length
              ? 'Không ăn'
              : meals[i].dish_ids[orderList[i]],
        });
      }
      return preorder(preorderForm);
    },
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['order'] });
    },
    onError: (err) => {
      setError(err);
    },
  });
  return { order, orderList, setOrderList };
};

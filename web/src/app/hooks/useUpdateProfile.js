'use client';

import { useMutation } from '@tanstack/react-query';
import { useQueryClient } from '@tanstack/react-query';
import { updateProfile } from '../utils/controllers/actions';

export const useUpdateProfile = (setError, handleClose, email, phone) => {
  const queryClient = useQueryClient();
  const handleCheckBeforeUpdate = (data) => {
    if (data.email === email || data.phone === phone) {
      if (data.email !== email) {
        handleUpdate.mutate({ email: data.email });
      } else if (data.phone !== phone) {
        handleUpdate.mutate({ phone: data.phone });
      } else {
        handleClose();
      }
    } else {
      handleUpdate.mutate(data);
    }
  };
  const handleUpdate = useMutation({
    mutationFn: (data) => updateProfile(data),
    onMutate: async ({ email, phone }) => {
      await queryClient.cancelQueries({ queryKey: ['profile'] });

      // Snapshot the previous value
      const previousProfile = queryClient.getQueryData(['profile']);

      // Optimistically update to the new value
      if (email || phone) {
        if (!email) {
          queryClient.setQueryData(['profile'], (old) => {
            return { ...old, phone };
          });
        } else if (!phone) {
          queryClient.setQueryData(['profile'], (old) => {
            return { ...old, email };
          });
        } else {
          queryClient.setQueryData(['profile'], (old) => {
            return { ...old, email, phone };
          });
        }
      }

      // Return a context object with the snapshotted value
      return { previousProfile };
    },
    onError: (err, newProfile, context) => {
      setError('Fail to fetch');
      queryClient.setQueryData(['profile'], context.previousProfile);
    },
    onSettled: (res) => {
      if (res.ok) {
        queryClient.invalidateQueries(['profile']);
        handleClose();
      } else {
        throw 'Un';
      }
    },
  });
  return { handleCheckBeforeUpdate, handleUpdate };
};

'use client';
import styles from '../Modal.module.css';
import StatusModal from './status-modal';
import { ColorfulButton } from '../../buttons/buttons';
import { zodResolver } from '@hookform/resolvers/zod';
import { useMutation } from '@tanstack/react-query';
import { resetPass } from '@/app/utils/controllers/actions';
import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { z } from 'zod';

function AccountModal() {
  const [error, setError] = useState(null);
  const handleUpdatePass = useMutation({
    mutationFn: (data) => resetPass(data),
    onSettled: (res) => {
      if (!res.ok) throw res;
    },
    onError: (err) => {
      setError(err.message);
    },
  });
  const schema = z
    .object({
      password: z
        .string()
        .min(8, { message: 'Password must be at least 8 chars' })
        .max(20, { message: 'Password must be at most 20 chars' }),
      confirmPassword: z
        .string()
        .min(8, { message: 'Confirm password must be at least 8 chars' })
        .max(20, { message: 'Confirm password must be at most 20 chars' }),
    })
    .superRefine(({ confirmPassword, password }, ctx) => {
      if (confirmPassword !== password) {
        ctx.addIssue({
          code: 'custom',
          message: 'The passwords did not match',
          path: ['confirmPassword'],
        });
      }
    });
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({ resolver: zodResolver(schema) });
  if (handleUpdatePass.isSuccess) {
    return (
      <StatusModal
        msg={'Changing password successfully!'}
        btnMsg={'Back to home'}
      />
    );
  }
  return (
    <div className={`${styles.modal}`}>
      <form
        action={handleSubmit((data) =>
          handleUpdatePass.mutate({ password: data.password }),
        )}
      >
        <div className="mx-10 mt-7 flex flex-col items-stretch">
          <h1>Account</h1>
          <div>
            <label htmlFor="new">New password</label>
            <br />
            <input
              className="w-[calc(20rem-4px)] max-sm:w-[calc(100vw-5rem-4px)]"
              type="password"
              name="newPassword"
              id="new"
              placeholder="8-20 characters"
              autoComplete="on"
              {...register('password')}
            />
            {errors.password && (
              <p className="text-end !text-red-600">
                {errors.password.message}
              </p>
            )}
          </div>
          <div>
            <label htmlFor="confirm">Confirm password</label>
            <br />
            <input
              className="w-[calc(20rem-4px)] max-sm:w-[calc(100vw-5rem-4px)]"
              type="password"
              name="confirmNewPassword"
              id="confirm"
              placeholder="8-20 characters"
              autoComplete="on"
              {...register('confirmPassword')}
            />
            {errors.confirmPassword && (
              <p className="text-end !text-red-600">
                {errors.confirmPassword.message}
              </p>
            )}
          </div>
          <div className="mt-2 flex justify-between">
            <div>
              <p className="!text-red-600">{error}</p>
            </div>
          </div>
          <ColorfulButton
            content={'Save new password'}
            isLoading={handleUpdatePass.isPending | handleUpdatePass.isSuccess}
          />
        </div>
      </form>
    </div>
  );
}

export default AccountModal;

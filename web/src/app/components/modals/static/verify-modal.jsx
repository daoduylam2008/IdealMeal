'use client';
import styles from '../Modal.module.css';
import { ColorfulButton, OrdinaryButton } from '../../buttons/buttons';
import { useState, useEffect } from 'react';
import { sendOTP, verifyOTP } from '@/app/utils/controllers/actions';
import { zodResolver } from '@hookform/resolvers/zod';
import { useMutation } from '@tanstack/react-query';
import { useRouter } from 'next/navigation';
import { useForm } from 'react-hook-form';
import { z } from 'zod';

function VerifyModal() {
  const router = useRouter();
  const [msg, setMsg] = useState('');
  const [error, setError] = useState(null);
  const [canSend, setCanSend] = useState(true);
  const [countDown, setCountDown] = useState(null);
  const [isSending, setIsSending] = useState(false);
  const schema = z.object({
    otp: z.string().length(6, { message: 'OTP must be 6 digits' }),
  });
  useEffect(() => {
    if (!canSend) {
      setCountDown(30);
      const countDownInterval = setInterval(() => {
        setCountDown((prev) => prev - 1);
      }, 1000);
      setTimeout(() => {
        clearInterval(countDownInterval);
        setCanSend(true);
      }, 30 * 1000);
    }
  }, [canSend]);
  const handleVerify = useMutation({
    mutationFn: (data) => {
      verifyOTP(data);
    },
  });
  const handleSend = useMutation({
    mutationFn: () => sendOTP(),
    onSuccess: () => {
      setMsg("We've sent an one-time-password to your email");
      setTimeout(() => {
        setMsg("Please fillout the code we've sent to your email to verify");
      }, 2000);
      // router.replace('/reset_password');
    },
  });
  const handleSendOTP = (e) => {
    e.preventDefault();
    setCanSend(false);
    handleSend.mutate();
  };

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({ resolver: zodResolver(schema) });
  return (
    <div className={`${styles.modal} `}>
      <form action={handleSubmit((data) => handleVerify.mutate(data))}>
        <div className="mx-10 mt-7 flex flex-col items-stretch">
          <h1 className="mb-3">Verify it's u</h1>
          <span className="p mb-5 text-center transition-all duration-300">
            {msg}
          </span>
          <div>
            <label htmlFor="otp">OTP</label>
            <br />
            <div className="flex">
              <input
                className="w-[calc(20rem-4px)] flex-1 max-sm:w-[calc(100vw-5rem-4px)]"
                type="text"
                name="otp"
                id="otp"
                placeholder="6-digits"
                autoComplete="on"
                {...register('otp')}
              />
              <div className="ml-4 flex w-20 flex-col items-stretch">
                <OrdinaryButton
                  content={'Send'}
                  isLoading={!canSend | handleSend.isLoading}
                  handleClick={handleSendOTP}
                />
              </div>
            </div>
            <div className="flex justify-between">
              <div className="flex justify-between">
                <div className="flex flex-col">
                  {!canSend && <p>{`${countDown}s left`}</p>}
                  <div>
                    <p className={`${!canSend && 'mt-1'} !text-red-600`}>
                      {error}
                    </p>
                  </div>
                </div>
              </div>
              {errors.otp && (
                <p className="text-end !text-red-600">{errors.otp.message}</p>
              )}
            </div>
          </div>

          <ColorfulButton
            content={'Next'}
            isLoading={handleVerify.isPending || handleVerify.isSuccess}
          />
        </div>
      </form>
    </div>
  );
}
export default VerifyModal;

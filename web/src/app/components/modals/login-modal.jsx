import Link from 'next/link';
import Modal from './modal-proto';
import { useMutation } from '@tanstack/react-query';
import { zodResolver } from '@hookform/resolvers/zod';
import { useRouter } from 'next/navigation';
import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { login } from '@/app/utils/controllers/auth';
import { z } from 'zod';

function LoginModal() {
  const router = useRouter();
  const [error, setError] = useState(null);

  const handleLogin = useMutation({
    mutationFn: (data) => login({ req: data }),
    onSuccess: (res) => {
      if (!res.ok) {
        throw res;
      }
      router.replace('/home');
    },
    onError: (err) => {
      if (err.status) {
        setError(err.message);
      } else {
        setError('Error fetching data');
      }
    },
  });
  // Validation
  const schema = z.object({
    email: z.string().email({ message: 'Invalid Email' }),
    password: z
      .string()
      .min(8, { message: 'Password must be at least 8 characters' })
      .max(20, { message: 'Password must have a maximum of 20 characters' }),
  });
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({ resolver: zodResolver(schema) });

  return (
    <Modal
      id={'login-modal'}
      header={'Login'}
      action={handleSubmit((data) => handleLogin.mutate(data))}
      content={'Login'}
      isLoading={handleLogin.isPending | handleLogin.isSuccess}
    >
      <div>
        <label htmlFor="email">Email</label>
        <br />
        <input
          className="mb-1 w-[calc(20rem-4px)] min-w-0 max-sm:w-[calc(100vw-5rem-4px)]"
          type="email"
          name="email"
          id="email"
          placeholder="abc@email.com"
          autoComplete="on"
          required
          {...register('email')}
        />
        {errors.email && (
          <p className="text-end !text-red-600">{errors.email.message}</p>
        )}
      </div>
      <div>
        <label htmlFor="password">Password</label>
        <br />
        <input
          className="mb-1 w-[calc(20rem-4px)] min-w-0 max-sm:w-[calc(100vw-5rem-4px)]"
          type="password"
          name="password"
          id="password"
          placeholder="8-20 characters"
          autoComplete="on"
          required
          {...register('password')}
        />
        {errors.password && (
          <p className="text-end !text-red-600">{errors.password.message}</p>
        )}
      </div>

      <div className="mt-2 flex justify-between">
        <div>
          <p className="!text-red-600">{error}</p>
        </div>
        <Link href="/verify">
          <p className="">Forget Password?</p>
        </Link>
      </div>
    </Modal>
  );
}

export default LoginModal;

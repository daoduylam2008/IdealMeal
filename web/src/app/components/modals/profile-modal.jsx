import Modal from './modal-proto';
import validator from 'validator';
import { useUpdateProfile } from '@/app/hooks/useUpdateProfile';
import { zodResolver } from '@hookform/resolvers/zod';
import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { z } from 'zod';

function ProfileModal({ phone, email }) {
  const [error, setError] = useState(null);

  // Validation
  const schema = z.object({
    phone: z
      .string()
      .refine(validator.isMobilePhone, { message: 'Invalid Phone Number' }),
    email: z.string().email({ message: 'Invalid Email' }),
  });

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm({ resolver: zodResolver(schema) });

  const handleClose = (e) => {
    if (e) {
      e.preventDefault();
    }
    const modal = document.getElementById('profile-modal');
    modal.close();
  };
  const { handleUpdate, handleCheckBeforeUpdate } = useUpdateProfile(
    setError,
    handleClose,
    email,
    phone,
  );

  return (
    <Modal
      id={'profile-modal'}
      header={'Profile'}
      action={handleSubmit((data) => handleCheckBeforeUpdate(data))}
      content={'Save profile info'}
      isLoading={handleUpdate.isPending}
    >
      <div>
        <label htmlFor="phone">Phone</label>
        <br />
        <input
          className="w-[calc(20rem-4px)] max-sm:w-[calc(100vw-5rem-4px)]"
          type="tel"
          name="phone"
          id="phone"
          defaultValue={phone}
          placeholder="123-456-7890"
          autoComplete="on"
          {...register('phone')}
        />
        {errors.phone && (
          <p className="text-end !text-red-600">{errors.phone.message}</p>
        )}
      </div>
      <div>
        <label htmlFor="email">Email</label>
        <br />
        <input
          className="w-[calc(20rem-4px)] max-sm:w-[calc(100vw-5rem-4px)]"
          type="email"
          name="email"
          id="email"
          defaultValue={email}
          placeholder="abc@email.com"
          autoComplete="on"
          {...register('email')}
        />
        {errors.email && (
          <p className="text-end !text-red-600">{errors.email.message}</p>
        )}
      </div>
      <div>
        <p className="!text-red-600">{error}</p>
      </div>
    </Modal>
  );
}

export default ProfileModal;

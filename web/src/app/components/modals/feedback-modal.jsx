'use client';
import Modal from './modal-proto';
import styles from './Modal.module.css';
import StatusModal from './status-modal';
import { zodResolver } from '@hookform/resolvers/zod';
import { useState } from 'react';
import { useForm } from 'react-hook-form';
import { Star } from '../icons';
import { z } from 'zod';

function FeedbackModal({ date, dish_id, countDown, handleSend, setClose }) {
  const [error, setError] = useState(null);
  // Validation
  const schema = z.object({
    rate: z
      .number()
      .int()
      .gte(1, { message: 'Rate should not be blank' })
      .lte(5, { message: 'Rate should not be blank' }),
    text: z.string(),
  });

  const {
    register,
    handleSubmit,
    formState: { errors },
    setValue,
    getValues,
  } = useForm({ resolver: zodResolver(schema), defaultValues: { rate: 0 } });
  const handleClose = (e) => {
    if (e) {
      e.preventDefault();
    }
    const modal = document.getElementById('feedback-modal');
    modal.close();
  };
  const handleChange = (e) => {
    const stars = document.querySelectorAll('.star');
    if (getValues('rate')) {
      stars[5 - getValues('rate')].classList.remove('selected-star');
      setValue('rate', (5 - e) % 5 || 5);
      stars[e].classList.add('selected-star');
    } else {
      setValue('rate', (5 - e) % 5 || 5);
      stars[e].classList.add('selected-star');
    }
  };

  const handleSubmitFeedback = (data) => {
    handleSend.mutate({ date, dish_id, ...data });
  };

  if (handleSend.isSuccess) {
    handleClose();
    const statusModal = document.getElementById('status-modal');
    statusModal.showModal();
    statusModal.addEventListener('close', () => {
      setClose(true);
    });
  }
  return (
    <>
      <Modal
        id={'feedback-modal'}
        header={'Rate your meal'}
        action={handleSubmit((data) => handleSubmitFeedback(data))}
        content={'Send'}
        isLoading={handleSend.isPending}
      >
        <div
          className={`flex -mt-5 h-20 flex-row-reverse items-stretch justify-between ${styles.stars}`}
        >
          {[...Array(5).keys()].map((e) => (
            <div
              className={`star flex flex-1 flex-col items-center justify-stretch hover:scale-110 ${styles.star}`}
              onClick={() => handleChange(e)}
              key={e}
              id={e}
            >
              <Star />
            </div>
          ))}
        </div>
        <input
          type="number"
          {...register('rate', { valueAsNumber: true })}
          hidden
        />
        {errors.rate && (
          <p className="text-end !text-red-600">{errors.rate.message}</p>
        )}
        <div>
          <textarea
            className="mt-3 w-[calc(20rem-4px)] resize-none max-sm:w-[calc(100vw-5rem-4px)]"
            name="text"
            id="text"
            placeholder="Your feedback (Optional)"
            rows="5"
            // autoComplete="on"
            {...register('text')}
          />
          {errors.text && (
            <p className="text-end !text-red-600">{errors.text.message}</p>
          )}
        </div>
        <div>
          <p className="!text-red-600">{error}</p>
        </div>
      </Modal>
      <StatusModal
        btnMsg={`Okay (Close after: ${countDown}s)`}
        msg={'Sending successfully! Tks for your feedback^^'}
      />
    </>
  );
}

export default FeedbackModal;

'use client';
import Modal from './modal-proto';
import FeedbackModal from './feedback-modal';
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { handleCloseModal } from './modal-proto';
import { sendedFeedback } from '@/app/utils/controllers/actions';
import { createFeedback } from '@/app/utils/controllers/actions';
import { useState } from 'react';
import { Qr } from '../icons';

function TodayModal(props) {
  const queryClient = useQueryClient();
  const [countDown, setCountDown] = useState(null);
  const [close, setClose] = useState(false);
  const hasSendedFeedback = useQuery({
    queryKey: ['feedback'],
    queryFn: () => sendedFeedback(),
  });
  const handleSend = useMutation({
    mutationFn: (data) => createFeedback(data),
    onSettled: () => {
      queryClient.invalidateQueries(['feedback']);
      setCountDown(5);
      const interval = setInterval(
        () => setCountDown((prev) => prev - 1),
        1000,
      );
      setTimeout(() => {
        clearInterval(interval);
        setCountDown(null);
      }, 5000);
    },
  });
  const handleOpenFeedback = () => {
    handleCloseModal({ id: 'today-modal' });
    if (!hasSendedFeedback.data) {
      const feedbackModal = document.getElementById('feedback-modal');
      feedbackModal.showModal();
    }
  };
  return (
    <>
      <Modal
        id={'today-modal'}
        header={'Today’s dish!'}
        action={handleOpenFeedback}
        content={hasSendedFeedback.data ? 'Okay' : 'Any feedback?'}
      >
        <div className="relative h-[calc(100vw-5rem-4px)] rounded border-2 p-5 sm:h-80">
          <div className="absolute inset-0 flex flex-col items-stretch justify-stretch">
            <div className="flex flex-1 items-center justify-center">
              <Qr className="m-10" />
            </div>
          </div>
        </div>
      </Modal>

      {!close && (countDown || !hasSendedFeedback.data) && (
        <FeedbackModal
          {...props}
          countDown={countDown}
          handleSend={handleSend}
          setClose={setClose}
        />
      )}
    </>
  );
}

export default TodayModal;

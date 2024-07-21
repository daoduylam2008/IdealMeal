import Modal from './modal-proto';
import { handleCloseModal } from './modal-proto';

function StatusModal({ msg, btnMsg }) {
  return (
    <Modal
      id={'status-modal'}
      header={'Status'}
      action={() => handleCloseModal({ id: 'status-modal' })}
      content={btnMsg}
    >
      <div className="rounded border-2 p-5">
        <div className="flex flex-col items-center justify-center">
          <span className="h4 text-center">{msg}</span>
        </div>
      </div>
    </Modal>
  );
}

export default StatusModal;

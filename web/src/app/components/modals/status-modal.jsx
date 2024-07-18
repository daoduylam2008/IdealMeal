import Modal from './modal-proto';

function StatusModal({ msg, btnMsg }) {
  const handleClose = (e) => {
    if (typeof e.preventDefault === 'function') {
      e.preventDefault();
    }
    const modal = document.getElementById('status-modal');
    modal.close();
  };
  return (
    <Modal
      id={'status-modal'}
      header={'Status'}
      action={handleClose}
      content={btnMsg}
    >
      <div className="rounded border-2 border-border p-5">
        <div className="flex flex-col items-center justify-center">
          <span className="h4 text-center">{msg}</span>
        </div>
      </div>
    </Modal>
  );
}

export default StatusModal;

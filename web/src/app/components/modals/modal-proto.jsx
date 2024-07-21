import styles from './Modal.module.css';
import { ColorfulButton } from '../buttons/buttons';
import { Cancel } from '../icons';

export default function Modal({ id, action, header, children, ...btn }) {
  const handleClose = (e) => {
    e.preventDefault();
    const modal = document.getElementById(id);
    modal.close();
  };
  return (
    <dialog id={id} className={`${styles.modal}`}>
      <form action={action}>
        <div className="absolute right-0 top-0 flex justify-end">
          <button onClick={handleClose} title="close-dialog">
            <div className={`${styles.cancelButton1} p-8`}>
              <div
                className={`${styles.cancelButton2} transition-transform duration-300`}
              >
                <Cancel />
              </div>
            </div>
          </button>
        </div>
        <div className="mx-10 mt-7 flex flex-col items-stretch">
          <h1>{header}</h1>
          {children}
          <ColorfulButton {...btn} />
        </div>
      </form>
    </dialog>
  );
}

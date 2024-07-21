import Link from 'next/link';
import { ArrowButton } from '../../buttons/buttons';
import { redirect } from 'next/navigation';
import styles from '../Modal.module.css';
import { useRouter } from 'next/navigation';

function StatusModal({ msg, btnMsg }) {
  const router = useRouter();

  const handleRedirect = () => {
    router.replace('/home');
  };
  return (
    <div className={`${styles.modal} `}>
      <div className="mx-10 mt-7 flex flex-col items-stretch">
        <h1>Status</h1>
        <div className="rounded border-2 p-5">
          <div className="flex flex-col items-center justify-center">
            <span className="h4 text-center">{msg}</span>
          </div>
        </div>

        <ArrowButton content={btnMsg} handleClick={handleRedirect} />
      </div>
    </div>
  );
}

export default StatusModal;

import styles from './Button.module.css';
import { Arrow } from '../icons';

export const ColorfulButton = ({
  content,
  isLoading,
  handleClick = () => {},
}) => (
  <button
    type="submit"
    disabled={isLoading}
    className={
      isLoading ? `${styles.button1} !rounded-xl` : `${styles.button1}`
    }
    onClick={handleClick}
  >
    <div
      className={
        isLoading ? `${styles.button2} !rounded-[0.6rem]` : `${styles.button2}`
      }
    >
      <span className={`${styles.button3}`}>
        {isLoading ? 'Loading...' : content}
      </span>
    </div>
  </button>
);

export const ArrowButton = ({ content, handleClick, className }) => (
  <button className={`${styles.button1}`} onClick={handleClick}>
    <div className={`${styles.button2} ${className}`}>
      <span className={`${styles.buttonlogin3} transition-all duration-300`}>
        {content}
      </span>
      <Arrow />
    </div>
  </button>
);

export const OrdinaryButton = ({ content, isLoading, handleClick }) => (
  <button
    type="submit"
    disabled={isLoading}
    onClick={handleClick}
    className={isLoading ? `${styles.button} !bg-border` : `${styles.button}`}
  >
    <span className="h3">{content}</span>
  </button>
);

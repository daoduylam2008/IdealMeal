import Link from 'next/link';
import Header from './components/header';
import { ArrowButton } from './components/buttons/buttons';

export default function NotFound() {
  return (
    <Header menu={false}>
      <h2>Not Found</h2>
      <p>Could not find requested resource</p>
      <Link href="/" className="flex w-52 flex-col">
        <ArrowButton content={'Back to home'} />
      </Link>
    </Header>
  );
}

import Header from '../components/header';

function Layout({ children }) {
  return (
    <Header menu={false}>
      <div className="relative flex h-full items-center justify-center bg-back max-sm:items-end">
        {children}
      </div>
    </Header>
  );
}

export default Layout;

import Header from '../components/header';

function Layout({ children }) {
  return <Header menu={true}>{children}</Header>;
}

export default Layout;

"use client";

import { Provider } from 'react-redux';
import { store } from './store/store';
//import { NotificationProvider } from "../../context/notification";
import { Inter } from "next/font/google";
import "./globals.css";
import Nav from "./components/nav";
import Footer from "./components/footer";
import { UserProvider } from "../../context/context";
const inter = Inter({ subsets: ["latin"] });

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  const isLoginPage = typeof window !== "undefined" && window.location.pathname === "/login"; 

  return (
    <html lang="en">
      <body>
        <Provider store={store}>
          <UserProvider>
            {/* <NotificationProvider> */}
              {!isLoginPage && <Nav />}  
              {children}
              <Footer />
            {/* </NotificationProvider> */}
          </UserProvider>
        </Provider>
      </body>
    </html>
  );
}
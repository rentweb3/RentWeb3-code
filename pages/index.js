import Head from "next/head";
import Image from "next/image";
import styles from "../styles/Home.module.css";
import Navbar from "./components/Navbar/Navbar";
import Home from "./components/Home/Home";
export default function Index() {
  return (
    <div className={styles.container}>
      <Head>
        <title>Rent Web3</title>
        <link rel="shortcut icon" href="./rw3.png" />
      </Head>
      <Home />
    </div>
  );
}

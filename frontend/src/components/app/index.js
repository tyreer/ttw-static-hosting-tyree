import React from 'react';
import styles from './index.module.css';
import logo from './logo.svg';

const App = () => (
  <div className={styles.root}>
    <header className={styles.header}>
      <img src={logo} className={styles.logo} alt="logo" />
      <p>
        Edit <code>src/App.js</code> and save to reload.
      </p>
      <a
        className={styles.link}
        href="https://reactjs.org"
        target="_blank"
        rel="noopener noreferrer"
      >
        Learn React
      </a>
    </header>
  </div>
);

export default App;

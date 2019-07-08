import React from 'react';
import { render } from 'react-snapshot';
import './index.css';
import App from './components/app';

if (process.env.NODE_ENV === 'production') {
  console.log('BUILD NUM : ', process.env.BUILD_NUM); // eslint-disable-line no-console
}

render(<App />, document.getElementById('root'));

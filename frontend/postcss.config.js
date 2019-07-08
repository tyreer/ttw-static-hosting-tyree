'use strict';

module.exports = {
  // Necessary for external CSS imports to work
  // https://github.com/facebook/create-react-app/issues/2677
  ident: 'postcss',
  plugins: {
    'postcss-import': {},
    'postcss-flexbugs-fixes': {},
    // Adds vendor prefixing based on your specified browser support in
    // package.json
    'postcss-preset-env': {
      autoprefixer: {
        flexbox: 'no-2009',
      },
      stage: 0,
    },
  },
};

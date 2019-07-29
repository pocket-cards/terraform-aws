import * as path from 'path';
import { Configuration, LoaderOptionsPlugin } from 'webpack';
import * as merge from 'webpack-merge';
import baseConfig from './webpack.base';

const LIBRARY_NAME = 'lodash';
const OUTPUT_PATH = path.resolve(__dirname, `../../build/${LIBRARY_NAME}/nodejs/node_modules/${LIBRARY_NAME}`);

const prod: Configuration = {
  mode: 'production',
  output: {
    filename: 'index.js',
    path: OUTPUT_PATH,
  },
  optimization: {
    minimize: false,
  },
  plugins: [
    new LoaderOptionsPlugin({
      debug: false,
    }),
  ],
};

export default merge.strategy({
  externals: 'replace',
})(baseConfig, prod);

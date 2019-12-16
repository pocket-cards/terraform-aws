import * as path from 'path';
import { Configuration, LoaderOptionsPlugin } from 'webpack';
import * as merge from 'webpack-merge';
import baseConfig from './webpack.base';

const LIBRARY_NAME = process.env.LIBRARY_NAME as string;
const OUTPUT_PATH = path.resolve(__dirname, `../../build/${LIBRARY_NAME}/nodejs/node_modules/${LIBRARY_NAME}`);
const entry = `./src/${LIBRARY_NAME}/index`;

const prod: Configuration = {
  mode: 'production',
  entry,
  externals: ['aws-sdk', 'aws-xray-sdk'],
  output: {
    filename: 'index.js',
    path: OUTPUT_PATH
  },
  optimization: {
    minimize: false
  },
  plugins: [
    new LoaderOptionsPlugin({
      debug: false
    })
  ]
};

export default merge.strategy({
  externals: 'replace'
})(baseConfig, prod);

import * as path from 'path';
import { Configuration, LoaderOptionsPlugin } from 'webpack';
import * as merge from 'webpack-merge';
import baseConfig from './webpack.base';

const prod: Configuration = {
  mode: 'production',
  externals: ['aws-sdk'],
  entry: './index',
  output: {
    filename: 'index.js',
    path: path.resolve(__dirname, '../../build/xray/nodejs/node_modules/aws-xray-sdk'),
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

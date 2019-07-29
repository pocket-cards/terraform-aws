import * as path from 'path';
import { Configuration, LoaderOptionsPlugin } from 'webpack';
import * as merge from 'webpack-merge';
import baseConfig from './webpack.base';

const prod: Configuration = {
  mode: 'production',
  entry: './index',
  output: {
    filename: 'index.js',
    path: path.resolve(__dirname, '../../build/moment/nodejs/node_modules/moment'),
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

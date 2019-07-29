import * as path from 'path';
import { Configuration, NoEmitOnErrorsPlugin, LoaderOptionsPlugin } from 'webpack';
import { CleanWebpackPlugin } from 'clean-webpack-plugin';

const configs: Configuration = {
  target: 'node',
  entry: './index',
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, './build'),
    publicPath: '/',
    libraryTarget: 'commonjs2',
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  externals: ['aws-sdk', 'aws-xray-sdk'],
  module: {
    rules: [
      {
        test: /\.ts$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'ts-loader',
          },
        ],
      },
    ],
  },
  plugins: [
    new NoEmitOnErrorsPlugin(),
    new LoaderOptionsPlugin({
      debug: false,
    }),
    new CleanWebpackPlugin(),
  ],
  bail: true,
};

export default configs;

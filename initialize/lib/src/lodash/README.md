# Webpack で Lambda Layer Library の作り方

## なにをやってる

インストールしたライブラリをコンパイルし、最小サイズのライブラリを作ります。

## なぜやる

`node_modules`をそのまま Zip 化した場合、ライブラリサイズが大きくなり、Lambda の`Code Start`時間が長くなります。

それを解消するため、必要なコードのみをコンパイルし、最小サイズのライブラリを作ります。

## Installation

共通化ライブラリ(COMMON_LIBRARY)をインストールする

```js
npm i -g yarn
yarn add COMMON_LIBRARY
```

## Exports

`index.ts`を編集し、適切な`export`を作成します。２種類があります

```js
module.exports = require('moment');
```

## Compile

`webpack.config.ts`の`LIBRARY_NAME`と`OUTPUT_PATH`を設定します。

```js
const LIBRARY_NAME = 'COMMON_LIBRARY';
const OUTPUT_PATH = path.resolve(__dirname, `../../build/${LIBRARY_NAME}/nodejs/node_modules/${LIBRARY_NAME}`);
```

## Execute

実行後、`nodejs`フォルダを Zip すれば、Lambda Layer として使用できます。

```
yarn start
```

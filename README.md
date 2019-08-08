## spfx-global-navigation

This is where you include your WebPart documentation.

### Additional Dependencies for Classic Mode Build ###
dependencies
@babel/polyfill

npm install @babel/polyfill --save

devDependencies
"css-loader": "^2.1.1",
"mini-css-extract-plugin": "^0.6.0",
"sass-loader": "^7.1.0",
"style-loader": "^0.23.1",

npm install css-loader mini-css-extract-plugin sass-loader style-loader --save-devDependencies

### Building the code for Classic Mode
Execute the following command:

npx webpack --config webpack.config.js


const { environment } = require('@rails/webpacker');
const webpack = require('webpack');

environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  'window.jQuery': 'jquery',
  moment: 'moment',
}));

module.exports = environment;

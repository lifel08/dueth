const { environment } = require('@rails/webpacker')

const webpack = require('webpack');
// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');
// Bootstrap 4 has a dependency over jQuery & Popper.js:
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    // $: 'jquery',
    // jQuery: 'jquery',
    // Popper: ['popper.js', 'default']
      $: 'jquery/src/jquery',
      jQuery: 'jquery/src/jquery',
      jquery: 'jquery/src/jquery',
      Popper: 'popper.js/dist/popper',
      moment: 'moment/moment',
      'window.jQuery': 'jquery'
  })
);
module.exports = environment

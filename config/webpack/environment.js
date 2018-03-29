const { environment } = require("@rails/webpacker");
const webpack = require('webpack');
const babelLoader = environment.loaders.get('babel');
delete babelLoader.exclude;

environment.plugins.prepend(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        "window.jQuery": "jquery",
        "window.$": "jquery",
        Popper: ['popper.js', 'default']
    })
);

environment.loaders.append('erb', {
    test: /\.erb$/,
    enforce: 'pre',
    exclude: /node_modules/,
    use: [{
        loader: 'rails-erb-loader',
        options: {
            runner: 'bin/rails runner'
        }
    }]
})
module.exports = environment;

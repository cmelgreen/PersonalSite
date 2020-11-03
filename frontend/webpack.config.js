const path = require('path');
module.exports = {
    entry: './src/javascript/index.js',
    output: {
        path: path.resolve(__dirname, 'dist'),
        filename: 'bundle.js'
    },
    module: {
        rules: [
            {
                test: /\.(png|jpe?g)$/,
                use: [{
                    loader: "file-loader",
                    options: {
                    esModule: false,
                    outputPath: "images",
                    publicPath: "images",
                    name: "[name].[ext]"
                    }
                }]
            }
        ]
    }
};

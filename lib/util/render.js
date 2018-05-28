'use strict';

const nunjucks = require('nunjucks');

module.exports = function(path, data) {
    return nunjucks.render(path, data);
}
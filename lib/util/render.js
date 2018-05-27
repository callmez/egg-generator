'use strict';

const nunjucks = require('nunjucks');

exports = function(path, data) {
    return nunjucks.render(path, data);
}
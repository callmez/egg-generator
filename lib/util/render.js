'use strict';

const nunjucks = require('nunjucks');
const pluralize = require('pluralize');

const env = new nunjucks.Environment(new nunjucks.FileSystemLoader('.'));
env.addFilter('pluralize', function(word) {
  return pluralize(word);
})

module.exports = function(path, data) {
  return env.render(path, data);
}
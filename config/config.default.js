'use strict';
const path = require('path');

const baseDir = path.resolve(`${__dirname}/..`);

module.exports = {
  generator: {
    controllerDir: path.resolve(`${baseDir}/app/controller`),
    serviceDir: path.resolve(`${baseDir}/app/service`),
    viewDir: path.resolve(`${baseDir}/app/view`),
    templateDir: path.resolve(`${baseDir}/app/template`),
    // app: true,
    // agent: true,
  },
};

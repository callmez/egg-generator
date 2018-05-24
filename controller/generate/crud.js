'use strict';

const Controller = require('egg').Controller;
const pluginDir

class CrudController extends Controller {
  async index() {
    this.ctx.render(`${__dirname}/../`)
  }
}

module.exports = CrudController;

'use strict';

const path = require('path');
const Controller = require('egg').Controller;
const render = require('../../../lib/util/render')

class CrudController extends Controller {
  async index() {
    const view = path.resolve(`${this.app.config.generator.config.viewDir}/generator/crud/index`)
    this.ctx.body = render(view);
  }

  async create() {
    this.ctx.body = await this.ctx.service.generator.crud.create();
  }
}

module.exports = CrudController;

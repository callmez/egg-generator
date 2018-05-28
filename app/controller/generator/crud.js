'use strict';

const path = require('path');
const Controller = require('egg').Controller;
const render = require('../../../lib/util/render')

class CrudController extends Controller {
  async index() {
    const view = path.resolve(`${this.app.config.generator.viewDir}/generator/crud/index.html`);
    this.ctx.body = render(view, {
      ctx: this.ctx,
    });
  }

  async create() {
    this.ctx.body = await this.ctx.service.generator.crud.create();
  }
}

module.exports = CrudController;

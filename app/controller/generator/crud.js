'use strict';

const Controller = require('egg').Controller;

class CrudController extends Controller {
  async index() {
    await this.ctx.render('/generator/crud/index');
  }

  async create() {
    this.ctx.body = await this.ctx.service.generator.crud.create();
  }
}

module.exports = CrudController;

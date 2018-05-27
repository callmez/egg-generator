/**
 * template config
 * @param filename {{identity}}
 */
'use strict';
const Controller = require('egg').Controller;

/**
 * {{identity}} controller
 */
class {{identity[0].toUpperCase() + identity.slice(1)}}Controller extends Controller {

  /**
   * {{identity}} paginate query
   */
  async index() {
    this.ctx.body = await this.ctx.service.{{identity}}.paginate();
  }

  /**
   * create {{identity}}
   */
  async create() {
    this.ctx.body = await this.ctx.service.{{identity}}.create();
  }

  /**
   * update {{identity}} by id
   */
  async update() {
    this.ctx.body = await this.ctx.service.{{identity}}.update();
  }

  /**
   * destory {{identity}} by id
   */
  async destory() {
    this.ctx.body = await this.ctx.service.{{identity}}.destory();
  }
}

module.exports = {{identity}}Controller;

/**
 * template config
 * @param filename <%= identity %>
 */
'use strict';
const Controller = require('egg').Controller;

/**
 * <%= identity %> controller
 */
class <%= identity | capitalize %>Controller extends Controller {

  /**
   * <%= identity %> paginate query
   */
  async index() {
    this.ctx.body = await this.ctx.service.<%= identity %>.paginate();
  }

  /**
   * create <%= identity %>
   */
  async create() {
    this.ctx.body = await this.ctx.service.<%= identity %>.create();
  }

  /**
   * update <%= identity %> by id
   */
  async update() {
    this.ctx.body = await this.ctx.service.<%= identity %>.update(this.ctx.params.id);
  }

  /**
   * destroy <%= identity %> by id
   */
  async destroy() {
    this.ctx.body = await this.ctx.service.<%= identity %>.destroy(this.ctx.params.id);
  }
}

module.exports = <%= identity | capitalize %>Controller;

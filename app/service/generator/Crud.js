'use strict';

const path = require('path');
const fs = require('fs-extra');
const AutoSequelize = require('sequelize-auto');
const Service = require('../../../lib/class/Service');
const generateSchema = require('../../../lib/util/generateSchema');

class Crud extends Service {

  async create(data = this.ctx.req.body || {}) {
    await this.validate({
      name: { type: 'string', required: true },
      identity: { type: 'regexp', pattern: /^[a-zA-Z]{1,20}$/, required: true },
      tableName: { type: 'string', required: true },
    }, data);
    data.model = await this.parseModel(data.tableName);
    const directory = path.resolve(`${this.app.config.generator.templateDir}/crud`);
    const result = await this.parse({ directory, data });

    if (parseInt(data.create) === 1) await this.write(result);
    return result;
  }

  async write(data) {
    for (const template of data.templates) {
      const file = path.resolve(`${this.app.baseDir}/${template.file}`);
      const dir = path.dirname(file);
      const s = await fs.ensureFile(file);
      // if (file.ensureFile(file)) {
      //
      // }
      file.mkdirs(dir);
    }
  }

  async parseModel(tableName) {
    const queryInterface = this.app.sequelize.getQueryInterface(); // 只支持单数据库
    const tables = await queryInterface.showAllTables();
    if (tables.indexOf(tableName) <= 0) this.ctx.throw('400', `table ${tableName} is not exists`);

    const { database, username, password } = this.app.sequelize.config;
    const auto = new AutoSequelize(database, username, password, {
      tables: [ tableName ],
      directory: false,
      spaces: true,
      indentation: 2,
    });
    const schema = await generateSchema(auto);
    return schema[tableName];
  }
}

module.exports = Crud;

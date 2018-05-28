'use strict';

const egg = require('egg');
const fs = require('fs-extra');
const path = require('path');
const globby = require('globby');
const Schema = require('async-validator');
const commentParser = require('comment-parser');
const render = require('../../lib/util/render');

class Service extends egg.Service {

  async validate(rules, data) {
    return new Promise(resolve => {
      const validator = new Schema(rules);
      validator.validate(data, errors => {
        if (errors) {
          this.ctx.throw(422, errors[0].message);
        }
        resolve(data);
      });
    });
  }

  async parse({ directory, data }) {
    const filepaths = globby.sync([ '**/*.tpl' ], { cwd: directory }).sort();
    const result = {
      data,
      files: [],
    };
    for (const filepath of filepaths) {
      const config = {
        template: filepath,
        data: {},
        file: filepath.replace('.tpl', '.js'), // 记录为模板名称
        content: null,
      };

      const fullpath = path.join(directory, filepath);
      if (!fs.statSync(fullpath).isFile()) continue;

      config.content = render(fullpath, result.data); // 获取模板内容
      const comments = commentParser(config.content);
      for (const comment of comments) {
        if (comment.description === 'template config' && comment.line === 0) { // 第一行 为template config的注释作为模板记录
          config.content = config.content.replace(/\/\*(\*(?!\/)|[^*])*\*\/\n/, ''); // 去掉首行template config注释
          for (const tag of comment.tags) {
            if (tag.tag === 'param' && tag.name) {
              config.data[tag.name] = tag.description;

              if (tag.name === 'directory') { // 自定义文件路径
                let filename = path.basename(config.file);
                if (filename.lastIndexOf('.') < 0) filename += '.js'; // 自动补全后缀
                config.file = `${tag.description}/${filename}`;
              } else if (tag.name === 'filename') { // 模板自定义文件名
                let filename = config.data[tag.name];
                if (filename.lastIndexOf('.') < 0) filename += '.js'; // 自动补全后缀
                config.file = `${path.dirname(config.file)}/${filename}`; // 替换文件名
              } else if (tag.name === 'alert') { // 只作为警告文件. 不会生成
                config.alert = parseInt(config.data[tag.name]);
              }
            }
          }
        }

        config.exists = await fs.pathExists(path.resolve(`${this.app.baseDir}/${config.file}`));
      }

      result.files.push(config);
    }

    return result;
  }

  async write(data) {
    for (const file of data.files) {
      if (file.alert === 1) continue;
      const _file = path.resolve(`${this.app.baseDir}/${file.file}`);
      const fileExists = await fs.pathExists(_file);
      if (!fileExists) {
        await fs.ensureFile(_file);
        await fs.writeFile(_file, file.content);

        file.created = true;
      }
    }
  }
}

module.exports = Service;

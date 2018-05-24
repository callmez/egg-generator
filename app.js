'use strict';

const path = require('path');

module.exports = app => {


  app.beforeStart(() => {
    const controller = app.controller;
    app.loader.loadController({
      directory: path.join(app.config., '/controller'),
    });
    app.controller = { ...controller, ...app.controller }; // loadToApp会覆盖, 重新保存旧设置

    app.router.get('/generate/crud', app.controller.generate.crud.index); // 挂载路由
  });
};

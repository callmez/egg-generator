'use strict';

const path = require('path');

module.exports = app => {
  const { router, loader, config } = app;

  app.beforeStart(() => {
    const controller = app.controller;
    loader.loadController({
      directory: config.generator.controllerDir,
    });
    app.controller = { ...controller, ...app.controller }; // loadToApp会覆盖, 重新保存旧设置

    // app.config.view.root.push(config.generator.viewDir); // app.view中加入视图目录
    // 挂载路由
    router.get('/generator/crud', app.controller.generator.crud.index); // 显示curd创建页面
    router.post('/generator/crud', app.controller.generator.crud.create); // crud创建
  });
};

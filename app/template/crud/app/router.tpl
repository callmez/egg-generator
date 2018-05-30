/**
 * template config
 * @param copy 1
 */
'use strict';

// 文件生成之后, 请按照以下步骤拷贝制定内容到app/router.js中
// 以便路由能指向到生成的controller中

// router.js
module.exports = app => {
  const { router, controller } = app;
  router.get('/', controller.home.index);

  /******************  拷贝以下内容  ******************/

  router.resources('/api/v1/<%= identity | pluralize %>', controller.api.v1.<%= identity %>);

  /******************  拷贝完毕  ******************/

};

# egg-generator

![image](https://user-images.githubusercontent.com/1625891/40605509-32e592dc-6295-11e8-809f-21fb8d9cb103.png)

基于eggjs框架搭建的代码生成器, 目前支持CRUD生成, 生成内容包括
- 服务端代码: eggjs restful 代码骨架文件
`app/controller/api/v1/{name}.js`
`app/model/{name}.js`
`app/service/{name}.js`
`app/router.js` // 路由注册代码

- 后台管理代码: ant design pro (page list, model form, update, delete) 挂历界面

## 从零开始搭建

### 快速搭建一个`eggjs` + `egg-sequelize` + `ant design pro`中后台项目并用`egg-generator`快速生成代码
> 注意: 数据层目前只支持生成基于[Sequelize](http://sequelizejs.com)的代码, 不支持`typescript`代码生成


### 第一步: 创建服务端(`egg.js`)
```bash
$ npm i egg-init -g // 安装eggjs官方生成器
$ egg-init project --type=simple // 生成项目
$ cd project // 进入项目目录
$ npm i // 安装依赖
```

### 第二步: 创建管理后台(`ant design pro`)
> 注意: 后台目录名必须为`backend`, 且必须在项目根目录下. 例如: `project/backend`
```bash
$ npm i ant-design-pro-cli -g // 安装ant design pro官方生成器
$ pro new // 生成后台, project name输入为: `backend`
```

> 注意:以上两部为项目初始搭建, 如果已有的项目中集成可以跳过以上两步. 独立后台项目可以软连接为`backend`既可. 前提必须按照`eggjs`和`ant design pro`标准目录结构.

### 第三部: 引入依赖
```bash
$ cd .. // 进入项目根目录
$ npm i egg-isequelize egg-async-ivalidator // 引入数据库操作类和数据验证类
$ npm i mysql2 // 如果是msyql数据库需引入mysql2, 其他数据库请查看Sequelize文档
```

```js
// 编辑 plugin.js, 加入以下代码
exports.sequelize = {
  enable: true,
  package: 'egg-isequelize'
}

exports.validate = {
  enable: true,
  package: 'egg-async-ivalidator',
};

exports.generator = {
  enable: true,
  package: 'egg-generator',
};
```

```js
// 编辑config.default.js 加入数据库操作源
exports.sequelize = {
  
  // single database
  client: {
    dialect: 'mysql',// support: mysql, mariadb, postgres, mssql
    database: 'test',
    host: 'localhost',
    port: '3306',
    username: 'root',
    password: '',
    hooks: {
      afterDefine(Model) {
        // add paginate method
        require('sequelize-pagination')({
          oneBaseIndex: true,
          pageSize: 20,
        })(Model);
      },
    },
  },
};
```

### 开始使用: 快速生成代码
```bash
$ cd project && npm run dev // 项目根目录启动服务
$ cd backend && npm start // 启动管理后台
```
访问 [http://127.0.0.1:7001/generator/crud](http://127.0.0.1:7001/generator/crud) 开始创建
/**
 * template config
 * @param filename {{identity}}
 */
'use strict';

module.exports = app => {
  const { model, Sequelize } = app;
  const DataTypes = Sequelize;

  const {{identity[0].toUpperCase() + identity.slice(1)}} = model.define('{{tableName}}', {{model.text|safe}}, {
    tableName: '{{tableName}}',
  });

  Object.assign({{identity[0].toUpperCase() + identity.slice(1)}}, {
    // Model extend
  });

  return {{identity[0].toUpperCase() + identity.slice(1)}};
};

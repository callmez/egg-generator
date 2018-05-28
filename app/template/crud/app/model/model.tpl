/**
 * template config
 * @param filename <%= identity %>
 */
'use strict';

module.exports = app => {
  const { model, Sequelize } = app;
  const DataTypes = Sequelize;

  const <%= identity | capitalize %> = model.define('<%= tableName %>', <%= model.text|safe %>, {
    tableName: '<%= tableName %>',
  });

  Object.assign(<%= identity | capitalize %>, {
    // Model extend
  });

  return <%= identity | capitalize %>;
};

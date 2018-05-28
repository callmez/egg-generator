'use strict';

/**
 * normalize query page params
 * @param {Object} query
 */
module.exports = function (query) {
  const result = {};

  const page = parseInt(query.page, 10);
  if (page > 0) {
    result.pageIndex = page;
  }

  const pageSize = parseInt(query.page_size, 10);
  if (pageSize > 0) {
    result.pageSize = pageSize > 200 ? 200 : pageSize; // 最大每页显示数
  }

  return result;
}
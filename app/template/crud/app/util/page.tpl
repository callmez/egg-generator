'use strict';

/**
 * normalize query page params
 * @param {Object} query
 */
module.exports = function (query) {
  const result = {};

  const page = parseInt(query.page, 10);
  if (page > 0) {
    result.pageIndex = data.page;
  }

  const pageSize = parseInt(query.page_size, 10);
  if (pageSize > 0) {
    result.pageSize = pageSize;
  }

  return result;
}
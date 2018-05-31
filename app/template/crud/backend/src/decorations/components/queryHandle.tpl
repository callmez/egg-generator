
/**
 * 为组件添加默认handleRemove处理函数和remove触发函数 (remove)
 * @param namespace
 * @return {Function}
 */
export default function({ namespace }) {
  /* eslint-disable no-param-reassign */
  return function (target){
    const type = namespace.indexOf('/') >= 0 ? namespace : `${namespace}/query`;
    function query(payload) {
      if (this.props.onQuery) {
        this.props.onQuery(payload);
      } else if (this.onQuery) {
        this.onQuery(payload);
      }
      return this.props.dispatch({
        type,
        payload,
      });
    }
    if (!target.prototype.handleQuery) {
      target.prototype.handleQuery = function(_query) {
        return query.call(this, {
          ...(this.props.query || {}),
          ..._query,
        });
      };
    }
    if (!target.prototype.handleReset) {
      target.prototype.handleReset = function(resetQuery = {}) {
        return query.call(this, resetQuery);
      };
    }
  };
};

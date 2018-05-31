import { message as Message } from 'antd';

/**
 * 为组件添加默认handleRemove处理函数和remove触发函数 (remove)
 * @param namespace
 * @return {Function}
 */
export default function({ namespace, message = '删除成功' }) {
  /* eslint-disable no-param-reassign */
  return function (target){
    if (!target.prototype.handleRemove) {
      const type = namespace.indexOf('/') >= 0 ? namespace : `${namespace}/remove`;
      target.prototype.handleRemove = function(payload) {
        return this.props.dispatch({ type, payload })
          .then(() => {
            if (message) Message.success(message);
          });
      };
    }
    if (!target.prototype.remove) {
      target.prototype.remove = target.prototype.handleRemove;
    }
  };
};

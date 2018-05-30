import lowerFirst from 'lodash/lowerFirst';
import upperFirst from 'lodash/upperFirst';

/**
 * 辅助控制Modal子组件显示/隐藏, 提供基础名称扩展相关方法, 数组表示多个Modal控制
 * 例如: value='form' 将会在组件中插入formVisible的state属性和handleFormVisible成控制方法
 * @param value
 * @return {Function}
 */
export default function(value) {
  /* eslint-disable no-param-reassign */
  return function (target){
    const methods = Array.isArray(value) ? value : [value];
    if (!target.prototype.state) target.prototype.state = {};
    for (const name of methods) {
      if (name) {
        const property = `${lowerFirst(name)}Visible`;
        const propertyHandle = `handle${upperFirst(property)}`;
        if (!target.prototype.state[property]) target.prototype.state[property] = false;
        if (!target.prototype[propertyHandle]) target.prototype[propertyHandle] = function (visible) {
          this.setState({ [property]: !!visible });
        };
      }
    }
  };
};

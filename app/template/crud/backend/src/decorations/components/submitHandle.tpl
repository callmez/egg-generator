import { message as Message } from 'antd';

/**
 * 为form组件添加默认handleSubmit处理函数和submit触发函数 (update, add)
 * 前提需要为Form.create()创建的组件, 可用onSubmit来hook流程
 * 通过name可以来设定函数名称
 * @param namespace
 * @return {Function}
 */
export default function({ namespace, message = '提交成功', name = 'submit' }) {
  const upperName = name[0].toUpperCase() + name.slice(1);
  const method = name;
  const handleMethod = `handle${upperName}`;
  const onMethod = `on${upperName}`
  /* eslint-disable no-param-reassign */
  return function (target){
    if (!target.prototype[handleMethod]) {
      target.prototype[handleMethod] = function(e) {
        return new Promise((resolve, reject) => {
          try{
            this.props.form.validateFields({ force: true }, (err, values) => {
              if (err) return;
              if (this.props[onMethod]) {
                resolve(this.props[onMethod](values, e));
              } else if (this[onMethod]) {
                resolve(this[onMethod](values, e));
              } else {
                const type = namespace.indexOf('/') >= 0 ? namespace : `${namespace}/${values.id ? 'update' : 'add'}`;
                this.props.dispatch({ type, payload: values })
                  .then(resolve)
                  .then(() => {
                    if (message) Message.success(message);
                  });
              }
            });
          } catch (err) {
            reject(err);
          }
        });
      };
    }

    if (!target.prototype[method]) {
      target.prototype[method] = target.prototype[handleMethod];
    }
  };
};

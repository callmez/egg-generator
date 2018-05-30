import { message as Message } from 'antd/lib/index';

/**
 * 为form组件添加默认handleSubmi处理函数和submit触发函数
 * 前提需要为Form.create()创建的组件,  可用onSubmit,onSubmitted来hook流程
 * @param namespace
 * @return {Function}
 */
export default function({ namespace, message = '提交成功' }) {
  /* eslint-disable no-param-reassign */
  return function (target){
    if (!target.prototype.submit) {
      target.prototype.submit = function() {
        return this.handleSubmit();
      };
    }
    if (!target.prototype.handleSubmit) {
      target.prototype.handleSubmit = function(e) {
        if (this.props.onSubmit) {
          return this.props.onSubmit(e);
        } else {
          return this.props.form.validateFields({ force: true }, (err, values) => {
            if (err) return;
            const type = namespace.indexOf('/') >= 0 ? namespace : (`${namespace}/${values.id ? 'update' : 'add'}`);
            this.props.dispatch({
              type,
              payload: values,
            })
              .then(this.props.onSubmitted)
              .then(() => {
                if (message) Message.success(message);
              });
          });
        }
      };
    }
  };
};

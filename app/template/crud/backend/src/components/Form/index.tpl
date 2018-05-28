/**
 * template config
 * @param directory backend/src/components/<%=identity | capitalize%>Form
 */
import React from 'react';
import { connect } from 'dva';
import {
  Form,
  Input,
  Select,
  message,
} from 'antd';

const FormItem = Form.Item;
const create = Form.create;

export default class extends React.PureComponent {

  submit() {
    this.handleSubmit();
  }

  handleSubmit(e) {
    if (this.props.onSubmit) {
      this.props.onSubmit(e);
    } else {
      this.props.form.validateFields({ force: true }, (err, values) => {
        if (err) return;
        this.props.dispatch({
          type: `<%=identity%>/${values.id ? 'update' : 'add'}`,
          payload: values,
        }).then(() => {
          message.success('提交成功!');
          if (this.props.onSubmitted) {
            this.props.onSubmitted()
          }
        });
      });
    }
  }


  render() {
    const { form: { getFieldDecorator }, types } = this.props;

    const formItemLayout = {
      labelCol: {
        xs: { span: 24 },
        sm: { span: 4 },
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 16 },
        md: { span: 10 },
      },
    };

    const editorFormItemLayout = {
      labelCol: {
        xs: { span: 24 },
        sm: { span: 4 },
      },
      wrapperCol: {
        xs: { span: 24 },
        sm: { span: 18 },

        md: { span: 18 },
      },
    };

    return (
      <Form onSubmit={this.handleSubmit.bind(this)}>
        <FormItem
          {...formItemLayout}
          label="组织名">
          {getFieldDecorator('name', {
            rules: [{

            }, {
              required: true, message: '请输入组织名称',
            }],
          })(<Input />)}
        </FormItem>
      </Form>
    );
  }
};

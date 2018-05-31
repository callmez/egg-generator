/**
 * template config
 * @param directory backend/src/components/<%= identity | capitalize %>Form
 */
import React from 'react';
import { connect } from 'dva';
import {
  Form,
  Input,
} from 'antd';

import createForm from '../../decorations/components/createForm';
import submitHandle from '../../decorations/components/submitHandle';

const FormItem = Form.Item;

@connect()
@createForm()
@submitHandle({ namespace: '<%= identity %>' })
export default class extends React.PureComponent {

  render() {
    const { form: { getFieldDecorator } } = this.props;

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

    const textareaFormItemLayout = {
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
      {% for name, field in model.fields %}
        <FormItem
          {...formItemLayout}
          label="<%= name %>"
        >
          {getFieldDecorator('<%= name %>', {
            rules: [
              // {
              //   required: true, message: '请输入<%= name %>',
              // },
            ],
          })(<Input placeholder="请输入<%= name %>" />)}
        </FormItem>
      {% endfor %}
      </Form>
    );
  }
};

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
@submitHandle('<%= identity %>')
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
      <Form onSubmit={this.handleSubmit}>

        <FormItem
          {...formItemLayout}
          label="id">
          {getFieldDecorator('id', {
            rules: [{
              // required: true, message: '请输入id',
            }, {

            }],
          })(<Input />)}
        </FormItem>

        <FormItem
          {...formItemLayout}
          label="name">
          {getFieldDecorator('name', {
            rules: [{
              // required: true, message: '请输入name',
            }, {

            }],
          })(<Input />)}
        </FormItem>

        <FormItem
          {...formItemLayout}
          label="logo">
          {getFieldDecorator('logo', {
            rules: [{
              // required: true, message: '请输入logo',
            }, {

            }],
          })(<Input />)}
        </FormItem>

        <FormItem
          {...formItemLayout}
          label="type">
          {getFieldDecorator('type', {
            rules: [{
              // required: true, message: '请输入type',
            }, {

            }],
          })(<Input />)}
        </FormItem>

        <FormItem
          {...formItemLayout}
          label="summary">
          {getFieldDecorator('summary', {
            rules: [{
              // required: true, message: '请输入summary',
            }, {

            }],
          })(<Input />)}
        </FormItem>

        <FormItem
          {...formItemLayout}
          label="created_at">
          {getFieldDecorator('created_at', {
            rules: [{
              // required: true, message: '请输入created_at',
            }, {

            }],
          })(<Input />)}
        </FormItem>

        <FormItem
          {...formItemLayout}
          label="updated_at">
          {getFieldDecorator('updated_at', {
            rules: [{
              // required: true, message: '请输入updated_at',
            }, {

            }],
          })(<Input />)}
        </FormItem>

      </Form>
    );
  }
};

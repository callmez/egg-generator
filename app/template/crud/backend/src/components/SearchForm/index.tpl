/**
 * template config
 * @param directory backend/src/components/<%= identity | capitalize %>SearchForm
 */
import React from 'react';
import { connect } from 'dva';
import {
  Row,
  Col,
  Form,
  Input,
  Icon,
  Button,
} from 'antd';

import styles from './index.less';
import createForm from '../../decorations/components/createForm';
import submitHandle from '../../decorations/components/submitHandle';
import queryHandle from '../../decorations/components/queryHandle';

const FormItem = Form.Item;

@connect()
@createForm()
@submitHandle({ message: false, name: 'search' })
@queryHandle({ namespace: '<%= identity %>' })
export default class extends React.PureComponent {

  state = {
    expand: false,
  };

  onSearch = this.handleQuery

  handleFormReset = () => {
    this.props.form.resetFields();
    return this.handleReset();
  }

  toggleFormExpand = () => {
    this.setState({ expand: !this.state.expand });
  }

  renderSimpleForm() {
    const { getFieldDecorator } = this.props.form;

    return (
      <Form onSubmit={this.handleSearch.bind(this)} layout="inline">
        <Row gutter={{ md: 8, lg: 24, xl: 48 }}>
        {% for name, field in model.fields %}{% if loop.index <= 2 %}
          <Col md={8} sm={24}>
            <FormItem
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
          </Col>
        {% endif %}{% endfor %}
          <Col md={8} sm={24}>
            <span className={styles.submitButtons}>
              <Button type="primary" htmlType="submit">
                查询
              </Button>
              <Button style={{ marginLeft: 8 }} onClick={this.handleFormReset}>
                重置
              </Button>
              <a style={{ marginLeft: 8 }} onClick={this.toggleFormExpand}>
                展开 <Icon type="down" />
              </a>
            </span>
          </Col>
        </Row>
      </Form>
    );
  }

  renderAdvancedForm() {
    const { getFieldDecorator } = this.props.form;

    return (
      <Form onSubmit={this.handleSearch.bind(this)} layout="inline">
        <Row gutter={{ md: 8, lg: 24, xl: 48 }}>
          {% for name, field in model.fields %}
          <Col md={8} sm={24}>
            <FormItem
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
          </Col>{% if loop.index % 3 == 0 %}
        </Row>
        <Row gutter={{ md: 8, lg: 24, xl: 48 }}>
          {% endif %}
          {% endfor %}
        </Row>
        <div style={{ overflow: 'hidden' }}>
          <span style={{ float: 'right', marginBottom: 24 }}>
            <Button type="primary" htmlType="submit">
              查询
            </Button>
            <Button style={{ marginLeft: 8 }} onClick={this.handleFormReset}>
              重置
            </Button>
            <a style={{ marginLeft: 8 }} onClick={this.toggleFormExpand}>
              收起 <Icon type="up" />
            </a>
          </span>
        </div>
      </Form>
    );
  }

  render() {
    const { expand } = this.state;
    return (
      <div className={styles.searchForm}>
        {expand ? this.renderAdvancedForm() : this.renderSimpleForm()}
      </div>
    );
  }
};

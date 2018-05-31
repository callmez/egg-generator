/**
 * template config
 * @param directory backend/src/routes/<%= identity | capitalize %>
 */

import React from 'react';
import { connect } from 'dva';
import {
  Card,
  Icon,
  Button,
  Dropdown,
  Menu,
  Modal,
} from 'antd';
import PageHeaderLayout from '../../layouts/PageHeaderLayout';

import styles from './List.less';
import <%= identity | capitalize %>Form from '../../components/<%= identity | capitalize %>Form';
import <%= identity | capitalize %>SearchForm from '../../components/<%= identity | capitalize %>SearchForm';
import <%= identity | capitalize %>List from '../../components/<%= identity | capitalize %>List';

import visibleHandle from '../../decorations/components/visibleHandle';

@connect()
@visibleHandle([ 'form' ])
export default class List extends React.PureComponent {
  state = {
    form: {},
    query: {},
    selectedRows: [],
  };

  handleMenuClick = e => {
    const { selectedRows } = this.state;
    /* eslint-disable no-useless-return */
    if (!selectedRows) return;

    switch (e.key) {
      case 'remove':
        // selected rows remove
        break;
      default:
        break;
    }
  };

  handleSelectRows = selectedRows => {
    this.setState({ selectedRows });
  };

  handleQuery = query => {
    this.setState({ query });
  }

  handleFormEdit = (form = {}) => {
    this.setState({ form });
    this.handleFormVisible(true);
  }

  renderForm() {
    const { form, formVisible } = this.state;

    return (
      <Modal
        title="<%= name %>管理"
        width={800}
        visible={formVisible}
        onCancel={() => this.handleFormVisible()}
        onOk={() => { this.formRef.submit().then(() => this.handleFormVisible(false)) }}
      >
        <<%= identity | capitalize %>Form
          fields={form}
          wrappedComponentRef={el => { this.formRef = el }}
        />
      </Modal>
    );
  }

  renderSearchForm() {
    const { query } = this.state;
    const props = {
      query,
      onQuery: this.handleQuery,
    };
    return (
      <<%= identity | capitalize %>SearchForm {...props} />
    );
  }

  renderList() {
    const { query } = this.state;
    const props = {
      query,
      onQuery: this.handleQuery,
      onFormEdit: this.handleFormEdit,
      onSelectedRows: this.handleSelectRows,
      ref: el => { this.listRef = el },
    };
    return (
      <<%= identity | capitalize %>List {...props} />
    );
  }

  render() {
    const { selectedRows } = this.state;

    const selectedMenu = (
      <Menu onClick={this.handleMenuClick} selectedKeys={[]}>
        <Menu.Item key="remove">删除</Menu.Item>
      </Menu>
    );

    return (
      <PageHeaderLayout title="<%= name %>管理">
        <Card bordered={false}>
          <div className={styles.list}>
            {this.renderSearchForm()}
            <div className={styles.listOperator}>
              <Button icon="plus" type="primary" onClick={() => this.handleFormEdit()}>新建</Button>
              {selectedRows.length > 0 && (
                <span>
                  <Dropdown overlay={selectedMenu}>
                    <Button>
                      更多操作 <Icon type="down" />
                    </Button>
                  </Dropdown>
                </span>
              )}
            </div>
            {this.renderList()}
          </div>
        </Card>
        {this.renderForm()}
      </PageHeaderLayout>
    );
  }
}

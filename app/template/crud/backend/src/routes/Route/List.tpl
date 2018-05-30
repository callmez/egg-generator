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
    selectedRows: [],
  };

  handleMenuClick = e => {
    const { selectedRows } = this.state;
    /* eslint-disable no-useless-return */
    if (!selectedRows) return;

    // switch (e.key) {
    //   case 'xxx':
    //     break;
    //   default:
    //     break;
    // }
  };

  handleSelectRows = rows => {
    this.setState({
      selectedRows: rows,
    });
  };

  handleFormEdit = (form = {}) => {
    this.setState({ form });
    this.handleFormVisible(true);
  }

  renderForm() {
    const { form, formVisible } = this.state;

    return (
      <Modal
        title="组织管理"
        width={800}
        visible={formVisible}
        onCancel={() => this.handleFormVisible()}
        onOk={() => this.formRef.submit()}
      >
        <<%= identity | capitalize %>Form
          fields={form}
          onSubmitted={() => this.handleFormVisible(false)}
          wrappedComponentRef={el => { this.formRef = el }}
        />
      </Modal>
    );
  }

  renderSearchForm() {
    return (
      <<%= identity | capitalize %>SearchForm />
    );
  }

  renderList() {
    return (
      <<%= identity | capitalize %>List
        onFormEdit={this.handleFormEdit}
        onSelectedRows={this.handleSelectRows}
      />
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

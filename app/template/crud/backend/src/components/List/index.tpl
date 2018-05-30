/**
 * template config
 * @param directory backend/src/components/<%= identity | capitalize %>List
 */
import React, { Fragment } from 'react';
import { connect } from 'dva';
import moment from 'moment';
import {
  Form,
  Icon,
  Dropdown,
  Menu,
  Badge,
  Divider,
  Popconfirm,
} from 'antd';

const createForm = Form.create;

import StandardTable from '../StandardTable';

// const getValue = obj =>
//   Object.keys(obj)
//     .map(key => obj[key])
//     .join(',');
// const statusMap = ['default', 'processing', 'success', 'error'];
// const status = ['关闭', '运行中', '已上线', '异常'];

@connect(({ <%= identity %>, loading }) => ({
  list: <%= identity %>.<%= identity | pluralize %>,
  loading: loading.models.<%= identity %>,
}))
@createForm()
export default class TableList extends React.PureComponent {
  state = {
    selectedRows: [],
  };

  componentDidMount() {
    this.handleQuery();
  }

  handleQuery = (query) => {
    this.props.dispatch({
      type: '<%= identity %>/query',
      payload: query,
    });
  }

  handleRemove = (id) => {
    this.props.dispatch({
      type: '<%= identity %>/remove',
      payload: id,
    });
  }

  handleQueryChange = (pagination, filtersArg, sorter) => {
    const { formValues } = this.state;

    // const filters = Object.keys(filtersArg).reduce((obj, key) => {
    //   const newObj = { ...obj };
    //   newObj[key] = getValue(filtersArg[key]);
    //   return newObj;
    // }, {});

    const params = {
      page: pagination.current,
      page_size: pagination.pageSize,
      ...formValues,
      // ...filters,
    };
    if (sorter.field) {
      params.sorter = `${sorter.field}_${sorter.order}`;
    }

    this.handleQuery(params);
  }

  render() {
    const { list, loading, onFormEdit, onSelectedRows } = this.props;
    const { selectedRows } = this.state;

    const props = {
      rowKey: 'id',
      onSelectRow: onSelectedRows,
      onChange: this.handleQueryChange,
      selectedRows,
      loading,
      data: {
        list: list.data,
        pagination: list.meta,
      },
      columns: [
        {
          title: 'id',
          dataIndex: 'id',
        },
        // {
        //   title: '描述',
        //   dataIndex: 'description',
        // },
        // {
        //   title: '服务调用次数',
        //   dataIndex: 'callNo',
        //   sorter: true,
        //   align: 'right',
        //   render: val => `${val} 万`,
        //   // mark to display a total number
        //   needTotal: true,
        // },
        // {
        //   title: '状态',
        //   dataIndex: 'status',
        //   filters: [
        //     {
        //       text: status[0],
        //       value: 0,
        //     },
        //     {
        //       text: status[1],
        //       value: 1,
        //     },
        //     {
        //       text: status[2],
        //       value: 2,
        //     },
        //     {
        //       text: status[3],
        //       value: 3,
        //     },
        //   ],
        //   onFilter: (value, record) => record.status.toString() === value,
        //   render(val) {
        //     return <Badge status={statusMap[val]} text={status[val]} />;
        //   },
        // },
        // {
        //   title: '更新时间',
        //   dataIndex: 'updatedAt',
        //   sorter: true,
        //   render: val => <span>{moment(val).format('YYYY-MM-DD HH:mm:ss')}</span>,
        // },
        {
          title: '操作',
          width: 150,
          render: (text, record) => {
            const listMenu = (
              <Menu>
                <Menu.Item>
                  <Popconfirm placement="top" title="确定要删除该项吗?" onConfirm={() => this.handleRemove(record.id)}>
                    <a>删除</a>
                  </Popconfirm>
                </Menu.Item>
              </Menu>
            );
            return (
              <Fragment>
                {onFormEdit ? [
                  <a key="edit" onClick={() => onFormEdit(record)}>编辑</a>,
                  <Divider key="divider" type="vertical" />
                ] : null}
                <Dropdown overlay={listMenu}>
                  <a>
                    更多 <Icon type="down" />
                  </a>
                </Dropdown>
              </Fragment>
            );
          }
        },
      ],
    }

    return (
      <StandardTable {...props}/>
    );
  }
}

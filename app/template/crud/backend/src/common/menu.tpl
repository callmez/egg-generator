/**
 * template config
 * @param copy 1
 */
import { isUrl } from '../utils/utils';

const menuData = [

  /******************  拷贝以下内容  ******************/

  {
    name: '<%= name %>',
    icon: 'table',
    path: '<%= identity %>',
    children: [
      {
        name: '<%= name %>管理',
        path: 'list',
      },
    ],
  },

/******************  拷贝完毕  ******************/

];

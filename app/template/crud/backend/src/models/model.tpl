/**
 * template config
 * @param filename <%= identity %>
 */
import { query, add, update, remove } from '../services/<%= identity %>';
import defaultPageData from '../utils/defaultPageData';

export default {
  namespace: '<%= identity %>',

  state: {
    <%= identity | pluralize %>: defaultPageData,
  },

  effects: {
    /**
     * pagination query <%= identity %>
     */
    *query({ payload, callback }, { call, put }) {
      const response = yield call(query, payload);
      yield put({
        type: 'save<%= identity | pluralize | capitalize %>',
        payload: response,
      });
      if (callback) callback(response);
    },
    /**
     * create <%= identity %>
     */
    *add({ payload, callback }, { call }) {
      const response = yield call(add, payload);
      if (callback) callback(response);
    },
    /**
     * update <%= identity %> by id
     */
    *update({ payload, callback }, { call }) {
      const response = yield call(update, payload);
      if (callback) callback(response);
    },
    /**
     * destroy <%= identity %> by id
     */
    *remove({ payload, callback }, { call }) {
      const response = yield call(remove, payload);
      if (callback) callback(response);
    },
  },

  reducers: {
    save<%= identity | pluralize | capitalize %>(state, action) {
      return {
        ...state,
        <%= identity | pluralize %>: action.payload,
      };
    },
  },
};

/**
 * template config
 * @param filename <%= identity %>
 */
import { query, add, update, remove } from '../services/<%= identity %>';
import {removeRule} from "../../../../../../../../../backend/src/services/api";

export default {
  namespace: '<%= identity %>',

  state: {
    <%= identity | pluralize %>: [],
  },

  effects: {
    *query({ payload, callback }, { call, put }) {
      const response = yield call(query, payload);
      yield put({
        type: 'save<%= identity | pluralize | capitalize %>',
        payload: response,
      });
      if (callback) callback(response);
    },
    *add({ payload, callback }, { call }) {
      const response = yield call(add, payload);
      if (callback) callback(response);
    },
    *update({ payload, callback }, { call }) {
      const response = yield call(update, payload);
      if (callback) callback(response);
    },
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

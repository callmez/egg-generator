/**
 * template config
 * @param filename <%= identity %>
 */
import { stringify } from 'qs';
import request from '../utils/request';

export async function query(params) {
  return request(`/api/v1/<%= identity | pluralize %>?${stringify(params)}`);
}

export async function add(params) {
  return request('/api/v1/<%= identity | pluralize %>', {
    method: 'POST',
    body: params,
  });
}

export async function update(params) {
  return request(`/api/v1/<%= identity | pluralize %>/${params.id}`, {
    method: 'PUT',
    body: params,
  });
}

export async function remove(id) {
  return request(`/api/v1/<%= identity | pluralize %>/${id}`, {
    method: 'DELETE',
  });
}



/**
 * template config
 * @param filename index.less
 * @param directory backend/src/components/<%= identity | capitalize %>SearchForm
 */
@import '~antd/lib/style/themes/default.less';

@media screen and (max-width: @screen-lg) {
  .searchForm :global(.ant-form-item) {
    margin-right: 24px;
  }
}

@media screen and (max-width: @screen-md) {
  .searchForm :global(.ant-form-item) {
    margin-right: 8px;
  }
}
.searchForm {
  :global {
    .ant-form-item {
      margin-bottom: 24px;
      margin-right: 0;
      display: flex;
      > .ant-form-item-label {
        width: auto;
        line-height: 32px;
        padding-right: 8px;
      }
      .ant-form-item-control {
        line-height: 32px;
      }
    }
    .ant-form-item-control-wrapper {
      flex: 1;
    }
  }
  .submitButtons {
    white-space: nowrap;
    margin-bottom: 24px;
  }
}

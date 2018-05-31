import moment from 'moment';
import { Form as BaseForm } from "antd";

const { create, createFormField } = BaseForm;

function normalize(value, field, options = {}) {
  let v = value;
  if (options.timeFields && options.timeFields.indexOf(field) >= 0 && value) {
    v = moment(value);
  }
  return v;
}

export default function(options) {
  return Component => {
    const Form = create({
      onFieldsChange(props, changedFields) {
        if (props.onFieldsChange) {
          const data = {};
          for (const key in changedFields) {
            data[key] = changedFields[key].value;
          }
          props.onFieldsChange(data);
        }
      },

      mapPropsToFields(props) {
        const fields = {};
        const propsFields = props.fields;
        for (const field in propsFields) {
          fields[field] = createFormField(typeof propsFields[field] !== 'object' ? {
            value: normalize(propsFields[field], field, options),
          } : propsFields[field]);
        }
        return fields;
      },
      ...options,
    })(Component);

    return Form;
  };
};

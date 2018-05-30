import moment from 'moment';
import { Form as BaseForm } from "antd";
const { create, createFormField } = BaseForm;

function normalize(value, field, options = {}) {
  if (options['timeFields'] && indexOf(options['timeFields'], field) >= 0 && value) {
    value = moment(value);
  }
  return value;
}

export default function(options) {
  return Component => {
    const Form = create({
      onFieldsChange(props, changedFields) {
        if (props.onFieldsChange) {
          const data = {};
          for (let key in changedFields) {
            data[key] = changedFields[key].value;
          }
          props.onFieldsChange(data);
        }
      },

      mapPropsToFields(props) {
        let fields = {};
        const propsFields = props.fields;
        for (let field in propsFields) {
          fields[field] = createFormField(typeof propsFields[field] != 'Object' ? {
            value: normalize(propsFields[field], field, options)
          } : propsFields[field]);
        }
        return fields;
      },
      ...options
    })(Component);

    return Form;
  };
};

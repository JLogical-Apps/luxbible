import { AdvancedTextInputComponent } from '@/sanity/components/AdvancedTextInputComponent';
import ConvertToSharedInput from '@/sanity/components/ConvertToSharedInput';
import { TypePickerInputComponent } from '@/sanity/components/TypePickerInputComponent';

export const tsxSanityConfig = {
  form: {
    components: {
      input: (props) => {
        const options = props.schemaType.options;
        if (props.schemaType?.name === 'string' && !options?.list) {
          return <AdvancedTextInputComponent {...props} />;
        } else if (
          props.schemaType?.name === 'array' &&
          options?.single === true
        ) {
          return <TypePickerInputComponent {...props} />;
        } else if (
          props.schemaType?.name === 'boolean' &&
          options?.convertToShared?.type
        ) {
          return (
            <ConvertToSharedInput
              type={options.convertToShared.type}
              innerField={options.convertToShared.innerField}
              {...props}
            />
          );
        } else {
          return props.renderDefault(props);
        }
      },
    },
  },
};

import SelectFormFieldTypeRenderer from '@/components/renderers/form-field-type/SelectFormFieldTypeRenderer';
import TextFormFieldTypeRenderer from '@/components/renderers/form-field-type/TextFormFieldTypeRenderer';
import { FormField } from '@/schema/objects/form-field';
import { FormFieldType } from '@/schema/objects/form-field-type/form-field-type';

export default function FormFieldTypeRenderer({
  formField,
  formFieldType,
}: {
  formField: FormField;
  formFieldType: FormFieldType;
}) {
  switch (formFieldType._type) {
    case 'textFormFieldType':
      return (
        <TextFormFieldTypeRenderer
          formField={formField}
          formFieldType={formFieldType}
        />
      );
    case 'selectFormFieldType':
      return (
        <SelectFormFieldTypeRenderer
          formField={formField}
          formFieldType={formFieldType}
        />
      );
  }
}

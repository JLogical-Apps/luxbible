import { vercelStegaCleanAll } from '@sanity/client/stega';
import React from 'react';

import { getTextFormFieldValues } from '@/lib/form/form-field-types';
import { FormField } from '@/schema/objects/form-field';
import { TextFormFieldType } from '@/schema/objects/form-field-type/text-form-field-type';

export default function TextFormFieldTypeRenderer({
  formField,
  formFieldType,
}: {
  formField: FormField;
  formFieldType: TextFormFieldType;
}) {
  const formFieldValues = getTextFormFieldValues(formFieldType.type);
  if (vercelStegaCleanAll(formFieldValues.element) === 'input') {
    return (
      <input
        name={formField.name}
        id={formField.name}
        required={formField.required}
        placeholder={formFieldType.placeholder}
        {...formFieldValues}
      />
    );
  } else if (vercelStegaCleanAll(formFieldValues.element) === 'textarea') {
    return (
      <textarea
        name={formField.name}
        id={formField.name}
        required={formField.required}
        placeholder={formFieldType.placeholder}
        {...formFieldValues}
      />
    );
  }
}

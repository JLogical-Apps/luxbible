import React from 'react';

import { FormField } from '@/schema/objects/form-field';
import { SelectFormFieldType } from '@/schema/objects/form-field-type/select-form-field-type';

export default function SelectFormFieldTypeRenderer({
  formField,
  formFieldType,
}: {
  formField: FormField;
  formFieldType: SelectFormFieldType;
}) {
  if (formFieldType.multiple) {
    return (
      <div className="flex flex-col mt-2.5 rounded-md border-0 gap-4">
        {formFieldType.options.map((option) => {
          const id = `${formField.name}:${option}`;
          return (
            <div key={option} className="flex flex-row items-center gap-2">
              <input
                name={id}
                id={id}
                type="checkbox"
                className="peer my-auto"
              />
              <label
                className="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70"
                htmlFor={id}
              >
                {option}
              </label>
            </div>
          );
        })}
      </div>
    );
  } else {
    return (
      <select
        className="mt-2.5 rounded-md border-0 px-3.5 py-2 bg-background-soft text-foreground shadow-sm ring-inset hover:ring-1 hover:ring-foreground-soft/80 placeholder:text-foreground-soft/80 focus:ring-2 focus:ring-inset focus:ring-emphasis sm:text-sm sm:leading-6 transition"
        name={formField.name}
        id={formField.name}
        required={formField.required}
      >
        {formFieldType.options.map((option) => (
          <option key={option} value={option}>
            {option}
          </option>
        ))}
      </select>
    );
  }
}

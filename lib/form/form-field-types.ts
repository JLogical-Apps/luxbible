export const textFormFieldTypeOptions = [
  {
    title: 'Text',
    value: 'text',
    element: 'input',
    type: 'text',
    autoComplete: undefined,
  },
  {
    title: 'Text Area',
    value: 'textArea',
    element: 'textarea',
    type: undefined,
    autoComplete: undefined,
  },
  {
    title: 'Name',
    value: 'name',
    element: 'input',
    type: 'text',
    autoComplete: 'name',
  },
  {
    title: 'Email',
    value: 'email',
    element: 'input',
    type: 'email',
    autoComplete: 'email',
  },
  {
    title: 'Phone',
    value: 'phone',
    element: 'input',
    type: 'phone',
    autoComplete: 'tel',
  },
] as const;

export function getTextFormFieldValues(formFieldType: string = 'text'): {
  element: string;
  type: string | undefined;
  autoComplete: string | undefined;
} {
  return textFormFieldTypeOptions
    .filter((option) => option.value == formFieldType)
    .map(({ element, type, autoComplete }) => ({
      element,
      type,
      autoComplete,
    }))[0];
}

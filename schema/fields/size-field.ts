const sizeOptions = [
  {
    title: 'Small',
    value: 'sm',
  },
  {
    title: 'Medium',
    value: 'md',
  },
  {
    title: 'Large',
    value: 'lg',
  },
] as const;

export type Size = (typeof sizeOptions)[number]['value'];

export const sizeField = {
  type: 'string',
  options: {
    list: sizeOptions,
  },
};

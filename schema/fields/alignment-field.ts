const alignmentOptions = ['start', 'center', 'end'] as const;

export type Alignment = (typeof alignmentOptions)[number];

export const alignmentField = {
  type: 'string',
  options: {
    list: alignmentOptions,
  },
};

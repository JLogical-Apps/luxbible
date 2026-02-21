const alignmentOptions = ['right', 'left', 'below'] as const;

export type MediaAlignment = (typeof alignmentOptions)[number];

export const mediaAlignmentField = {
  type: 'string',
  options: {
    list: alignmentOptions,
  },
};

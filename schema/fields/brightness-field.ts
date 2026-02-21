const brightnessOptions = ['light', 'dark'] as const;

export type Brightness = (typeof brightnessOptions)[number];

export const brightnessField = {
  type: 'string',
  options: {
    list: brightnessOptions,
  },
};

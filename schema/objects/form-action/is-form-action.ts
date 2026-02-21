import { SanityMixin } from '@/schema/sanity-mixin';

export type IsFormAction = {
  enabled: boolean;
};

export const isFormActionMixin: SanityMixin = {
  fields: [
    {
      type: 'boolean',
      name: 'enabled',
      title: 'Enabled',
      initialValue: true,
    },
  ],
  groqQueryPart: `
    enabled
  `,
};

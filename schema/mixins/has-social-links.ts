import { SanityMixin } from '@/schema/sanity-mixin';

export type HasSocialLinks = {
  email: string;
  facebook: string;
  instagram: string;
  twitter: string;
  youTube: string;
  linkedIn: string;
};

export const hasSocialLinksMixin: SanityMixin = {
  groups: [
    {
      name: 'social',
      title: 'Social Links',
    },
  ],
  fields: [
    {
      type: 'string',
      name: 'email',
      title: 'Email',
      group: 'social',
    },
    {
      type: 'string',
      name: 'facebook',
      title: 'Facebook',
      group: 'social',
    },
    {
      type: 'string',
      name: 'instagram',
      title: 'Instagram',
      group: 'social',
    },
    {
      type: 'string',
      name: 'twitter',
      title: 'Twitter',
      group: 'social',
    },

    {
      type: 'string',
      name: 'youTube',
      title: 'YouTube',
      group: 'social',
    },
    {
      type: 'string',
      name: 'linkedIn',
      title: 'LinkedIn',
      group: 'social',
    },
  ],
  groqQueryPart: `
    email,
    facebook,
    instagram,
    twitter,
    youTube,
    linkedIn,
  `,
};

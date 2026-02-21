import { IconUser } from '@tabler/icons-react';
import { defineType } from 'sanity';

import {
  ImageMedia,
  imageMediaRecord,
} from '@/schema/documents/media/image-media';
import { record } from '@/schema/sanity-type';

export type Author = {
  name: string;
  profilePicture: ImageMedia;
};

export const authorRecord = record({
  sanitySchema: () =>
    defineType({
      type: 'document',
      name: 'author',
      title: 'Author',
      icon: IconUser,
      fields: [
        {
          name: 'name',
          title: 'Name',
          type: 'string',
          validation: (Rule) => Rule.required(),
        },
        {
          name: 'profilePicture',
          title: 'Profile Picture',
          type: 'reference',
          to: imageMediaRecord.typeOption,
          validation: (Rule) => Rule.required(),
        },
      ],
      preview: {
        select: {
          name: 'name',
          profilePicture: 'profilePicture.image.asset',
        },
        prepare({ name, profilePicture }) {
          return {
            title: name,
            media: profilePicture,
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      name,
      profilePicture->{${imageMediaRecord.getGroqQueryPart()}}
    `;
  },
});

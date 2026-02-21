import { PortableTextBlock } from '@portabletext/types';
import { IconAddressBook } from '@tabler/icons-react';
import { defineType } from 'sanity';

import { convertToShared } from '@/sanity/plugins/convert-to-shared';
import { Form, formRecord } from '@/schema/documents/form';
import { Media, mediaRecord } from '@/schema/documents/media/media';
import { PageBlockBase } from '@/schema/documents/page-block/page-block';
import { isElementMixin } from '@/schema/mixins/is-element';
import {
  inlineRichText,
  inlineRichTextQueryPart,
} from '@/schema/richtext/inline-rich-text';
import { record } from '@/schema/sanity-type';

export interface ContactUsPageBlock extends PageBlockBase {
  _type: 'contactUsPageBlock';
  title?: PortableTextBlock[];
  description?: PortableTextBlock[];
  profilePicture?: Media;
  introduction?: string;
  form: Form;
}

export const contactUsPageBlockRecord = record({
  mixins: [isElementMixin],
  sanitySchema: () =>
    defineType({
      name: 'contactUsPageBlock',
      title: 'Contact Us',
      type: 'object',
      icon: IconAddressBook,
      fields: [
        convertToShared({
          type: 'sharedPageBlock',
          innerField: 'pageBlock',
        }),
        {
          type: 'reference',
          name: 'form',
          title: 'Form',
          to: formRecord.typeOption,
        },
        {
          ...inlineRichText,
          name: 'title',
          title: 'Title',
        },
        {
          ...inlineRichText,
          name: 'description',
          title: 'Description',
        },
        {
          type: 'reference',
          name: 'profilePicture',
          title: 'Profile Picture',
          to: mediaRecord.typeOption,
        },
        {
          name: 'introduction',
          title: 'Introduction',
          type: 'string',
        },
      ],
      preview: {
        prepare() {
          return {
            title: 'Contact Us',
          };
        },
      },
    }),
  groqQueryPart(): string {
    return `
      form->{${formRecord.getGroqQueryPart()}},
      title[]{${inlineRichTextQueryPart}},
      description[]{${inlineRichTextQueryPart}},
      profilePicture->{${mediaRecord.getGroqQueryPart()}},
      introduction,
    `;
  },
});

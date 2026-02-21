import { tablerIconsConfig } from '@/sanity/utils/tabler-icons-config';

export const iconField = {
  type: 'iconPicker',
  name: 'icon',
  title: 'Icon',
  description: (
    <p>
      Find a reference of the icons{' '}
      <a href="https://tabler.io/icons" target="_blank">
        here
      </a>
    </p>
  ),
  options: {
    ...tablerIconsConfig,
    storeSvg: true,
  },
};

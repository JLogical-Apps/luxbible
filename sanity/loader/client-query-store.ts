import { createQueryStore } from '@sanity/react-loader';

import { client } from '@/sanity/lib/client';

export const clientQueryStore = createQueryStore({
  ssr: false,
  client: client,
});

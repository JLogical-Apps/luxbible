import { SanityDocument } from 'sanity';
import {
  DefaultDocumentNodeResolver,
  StructureBuilder,
} from 'sanity/structure';
import { Iframe } from 'sanity-plugin-iframe-pane';

import { linkableImplementations } from '@/schema/interfaces/linkable';
import { instantiateDocument } from '@/schema/sanity-interface';

// Import this into the deskTool() plugin
export const defaultDocumentNode: DefaultDocumentNodeResolver = (
  S,
  { schemaType },
) => {
  const isLinkable = linkableImplementations.find(
    (impl) => impl.type == schemaType,
  );
  if (isLinkable) {
    return S.document().views(previewView(S));
  }

  return S.document().views([S.view.form()]);
};

export function previewView(S: StructureBuilder) {
  return [
    S.view.form(),
    S.view
      .component(Iframe)
      .options({
        url: {
          origin: 'same-origin',
          preview: async (document: SanityDocument) =>
            (await instantiateDocument(document, linkableImplementations)).path,
          draftMode: '/api/draft',
        },
        reload: {
          button: true,
        },
      })
      .title('Preview'),
  ];
}

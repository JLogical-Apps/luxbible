/**
 * This plugin contains all the logic for setting up the singletons
 */

import { type DocumentDefinition } from 'sanity';
import { type StructureResolver } from 'sanity/structure';

import { previewView } from '@/sanity/plugins/iframe-preview';

export const singletonPlugin = (types: string[]) => {
  return {
    name: 'singletonPlugin',
    document: {
      // Hide 'Singletons (such as Home)' from new document options
      // https://user-images.githubusercontent.com/81981/195728798-e0c6cf7e-d442-4e58-af3a-8cd99d7fcc28.png
      newDocumentOptions: (prev, { creationContext }) => {
        if (creationContext.type === 'global') {
          return prev.filter(
            (templateItem) => !types.includes(templateItem.templateId),
          );
        }

        return prev;
      },
      // Removes the "duplicate" action on the Singletons (such as Home)
      actions: (prev, { schemaType }) => {
        if (types.includes(schemaType)) {
          return prev.filter(({ action }) => action !== 'duplicate');
        }

        return prev;
      },
    },
  };
};

// The StructureResolver is how we're changing the DeskTool structure to linking to document (named Singleton)
// like how "Home" is handled.
export const pageStructure = ({
  singletons = [],
  medias = [],
  hidden = [],
}: {
  singletons?: DocumentDefinition[];
  medias?: DocumentDefinition[];
  hidden?: string[];
}): StructureResolver => {
  return (S) => {
    // Goes through all of the singletons that were provided and translates them into something the
    // Desktool can understand
    const singletonItems = singletons.map((typeDef) => {
      return S.listItem()
        .title(typeDef.title!)
        .icon(typeDef.icon)
        .child(
          S.editor()
            .id(typeDef.name)
            .schemaType(typeDef.name)
            .documentId(typeDef.name)
            .views(previewView(S)),
        );
    });

    const mediaItems = S.documentTypeListItems().filter((listItem) =>
      medias.find((media) => media.name === listItem.getId()),
    );

    // The default root list items (except custom ones)
    const defaultListItems = S.documentTypeListItems().filter(
      (listItem) =>
        !singletons.find((singleton) => singleton.name === listItem.getId()) &&
        !medias.find((media) => media.name === listItem.getId()) &&
        !hidden.find((hidden) => hidden === listItem.getId()),
    );

    return S.list()
      .title('Content')
      .items([
        ...singletonItems,
        S.divider(),
        ...defaultListItems,
        S.divider(),
        ...mediaItems,
      ]);
  };
};

import { SanityDocument } from 'sanity';

export interface SanityImplementation<I> {
  type: string;
  queryPart: string;

  instantiate(obj: Record<string, any> & { _type: string }): I;

  instantiateDocument(document: SanityDocument): Promise<I>;
}

export function createImplementation<T extends { _type: string }, I>({
  type,
  queryPart,
  instantiate,
  instantiateDocument,
}: {
  type: string;
  queryPart: string;
  instantiate: (obj: T) => I;
  instantiateDocument: (document: SanityDocument) => Promise<I>;
}): SanityImplementation<I> {
  return {
    type,
    queryPart,
    instantiate(obj: Record<string, any> & { _type: string }): I {
      return instantiate(obj as T);
    },
    instantiateDocument(document: SanityDocument): Promise<I> {
      return instantiateDocument(document);
    },
  };
}

export function getInterfaceQuery<T>(
  implementations: SanityImplementation<T>[],
) {
  const extractions = implementations
    .map(
      (implementation) =>
        `_type == "${implementation.type}" => {${implementation.queryPart}}`,
    )
    .join(',');

  return `
    _type,
    ${extractions},
  `;
}

export function instantiate<T>(
  object: Record<string, any> & { _type: string },
  implementations: SanityImplementation<T>[],
) {
  console.log({ object });
  return implementations
    .find((implementation) => implementation.type === object._type)!
    .instantiate(object);
}

export function instantiateDocument<T>(
  document: SanityDocument,
  implementations: SanityImplementation<T>[],
) {
  return implementations
    .find((implementation) => implementation.type === document._type)!
    .instantiateDocument(document);
}

import { FieldDefinition, FieldGroupDefinition } from 'sanity';

export interface SanityMixin {
  groups?: FieldGroupDefinition[];
  fields?: FieldDefinition[];
  groqQueryPart: string;
  mixins?: SanityMixin[];
}

export function unwrapMixin({
  groups = [],
  fields = [],
  groqQueryPart,
  mixins = [],
}: SanityMixin): {
  groups: FieldGroupDefinition[];
  fields: FieldDefinition[];
  groqQueryPart: string;
} {
  const unwrappedMixins = mixins.map((mixin) => unwrapMixin(mixin));
  return {
    groups: [...groups, ...unwrappedMixins.flatMap((mixin) => mixin.groups)],
    fields: [...fields, ...unwrappedMixins.flatMap((mixin) => mixin.fields)],
    groqQueryPart: [
      groqQueryPart,
      ...unwrappedMixins.map((mixin) => mixin.groqQueryPart),
    ].join(''),
  };
}

import Query from '@/sanity/lib/query';
import { SanityMixin, unwrapMixin } from '@/schema/sanity-mixin';

export interface SanityType<T> {
  getSanitySchemas(): any[];

  getGroqQueryPart(): string;

  fetchFirst<I>({
    condition,
    orderBy,
  }: {
    condition?: string;
    orderBy?: string | string[];
  }): Query<I, T | null>;

  fetchAll<I>({
    condition,
    start,
    end,
    orderBy,
  }: {
    condition?: string;
    start?: number;
    end?: number;
    orderBy?: string | string[];
  }): Query<I, T[]>;
}

export function record<T>({
  sanitySchema,
  groqQueryPart,
  mixins = [],
}: {
  sanitySchema: () => any;
  groqQueryPart(): string;
  mixins?: SanityMixin[];
}): SanityType<T> & {
  sanitySchema: any;
  typeOption: Array<{ type: string }>;
  referenceTypeOption: Array<{ type: 'reference'; to: { type: string } }>;
  sharedOrOneOff: {
    type: 'array';
    options: {};
    of: Array<{}>;
  };
  getSharedOrOneOffGroqQueryPart(fieldName: string): string;
} {
  const unwrappedMixins = mixins.map((mixin) => unwrapMixin(mixin));

  const { groups = [], fields = [], ...props } = sanitySchema();

  const schema = {
    groups: [...groups, ...unwrappedMixins.flatMap((mixin) => mixin.groups)],
    fields: [...fields, ...unwrappedMixins.flatMap((mixin) => mixin.fields)],
    ...props,
  };

  return {
    getSanitySchemas(): Array<any> {
      return [schema];
    },
    sanitySchema: schema,
    sharedOrOneOff: {
      type: 'array',
      of: [
        { type: schema.name },
        {
          type: 'reference',
          to: { type: schema.name },
        },
      ],
      options: {
        single: true,
      },
    },
    getSharedOrOneOffGroqQueryPart(fieldName: string): string {
      const fullGroqQueryPart = [
        groqQueryPart(),
        ...unwrappedMixins.map((mixin) => mixin.groqQueryPart),
      ].join('\n');
      return `
        ${fieldName}[0]._type == "${schema.name}" => ${fieldName}[0]{${fullGroqQueryPart}},
        ${fieldName}[0]._type == "reference" => ${fieldName}[0]->{${fullGroqQueryPart}},
      `;
    },
    getGroqQueryPart(): string {
      return [
        '_type,',
        groqQueryPart(),
        ...unwrappedMixins.map((mixin) => mixin.groqQueryPart),
      ].join('\n');
    },
    typeOption: [{ type: schema.name }],
    referenceTypeOption: [{ type: 'reference', to: { type: schema.name } }],
    fetchFirst({
      condition,
      orderBy,
    }: {
      condition?: string;
      orderBy?: string | string[];
    }): Query<Record<string, never>, T> {
      return {
        query: `*[_type == "${schema.name}"${
          condition ? ` && ${condition}` : ''
        }][0]{${this.getGroqQueryPart()}}${getOrderByText(orderBy)}`,
      };
    },
    fetchAll<I>({
      condition,
      start,
      end,
      orderBy,
    }: {
      condition?: string;
      start?: number;
      end?: number;
      orderBy?: string | string[];
    }): Query<I[], T> {
      return {
        query: `*[_type == "${schema.name}"${
          condition ? ` && ${condition}` : ''
        }]${getSliceText(
          start,
          end,
        )}{${this.getGroqQueryPart()}}${getOrderByText(orderBy)}`,
      };
    },
  };
}

export function abstractRecord<T extends SanityType<any>[]>({
  records,
  mixins = [],
}: {
  records: T;
  mixins?: Array<SanityMixin>;
}): T[number] & {
  typeOption: { type: string }[];
} {
  const unwrappedMixins = mixins.map((mixin) => unwrapMixin(mixin));
  return {
    getSanitySchemas(): Array<any> {
      return records.map((record) => {
        const {
          groups = [],
          fields = [],
          ...props
        } = record.getSanitySchemas()[0];

        return {
          groups: [
            ...groups,
            ...unwrappedMixins.flatMap((mixin) => mixin.groups),
          ],
          fields: [
            ...fields,
            ...unwrappedMixins.flatMap((mixin) => mixin.fields),
          ],
          ...props,
        };
      });
    },
    getGroqQueryPart(): string {
      return [
        `_type`,
        unwrappedMixins.map((mixin) => mixin.groqQueryPart).join('\n'),
        records.map(
          (record) =>
            `_type == "${
              record.getSanitySchemas()[0].name
            }" => {${record.getGroqQueryPart()}}`,
        ),
      ]
        .filter((e) => e)
        .join(',');
    },
    typeOption: records
      .flatMap((record) =>
        record.getSanitySchemas().flatMap((schema) => schema.name),
      )
      .map((typeName) => ({ type: typeName })),
    fetchFirst(): Query<Record<string, never>, T> {
      throw new Error('Cannot query an abstract type!');
    },
    fetchAll<I>(): Query<I[], T> {
      throw new Error('Cannot query an abstract type!');
    },
  };
}

function getOrderByText(orderBy: string | string[] | undefined) {
  if (!orderBy) {
    return '';
  }
  if (typeof orderBy === 'string') {
    return `| order(${orderBy})`;
  } else {
    return `| ${orderBy.map((orderBy) => `order(${orderBy})`).join(' | ')}`;
  }
}

function getSliceText(start?: number, end?: number) {
  if (!start && !end) {
    return '';
  }

  if (start && !end) {
    throw new Error(`Cannot define a start without an end!`);
  }

  return `[${start ?? 0}..${end}]`;
}

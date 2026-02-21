import { groq } from 'next-sanity';

export interface Icon {
  svg: string;
}

export const iconQueryPart = groq`
  svg,
`;

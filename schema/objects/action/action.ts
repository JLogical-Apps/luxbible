import {
  ExternalUrlAction,
  externalUrlActionRecord,
} from '@/schema/objects/action/external-url-action';
import { IdAction, idActionRecord } from '@/schema/objects/action/id-action';
import {
  InternalUrlAction,
  internalUrlActionRecord,
} from '@/schema/objects/action/internal-url-action';
import { abstractRecord } from '@/schema/sanity-type';

export type Action = IdAction | InternalUrlAction | ExternalUrlAction;
export type ActionBase = {
  _type: string;
};

export const actionRecord = abstractRecord({
  records: [idActionRecord, internalUrlActionRecord, externalUrlActionRecord],
});

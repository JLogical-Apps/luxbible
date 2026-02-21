import {
  EmailFormAction,
  emailFormActionRecord,
} from '@/schema/objects/form-action/email-form-action';
import {
  IsFormAction,
  isFormActionMixin,
} from '@/schema/objects/form-action/is-form-action';
import {
  PrintFormAction,
  printFormActionRecord,
} from '@/schema/objects/form-action/print-form-action';
import { abstractRecord } from '@/schema/sanity-type';

export type FormAction = PrintFormAction | EmailFormAction;
export type FormActionBase = IsFormAction & {
  _type: string;
};

export const formActionRecord = abstractRecord({
  mixins: [isFormActionMixin],
  records: [printFormActionRecord, emailFormActionRecord],
});

import {
  SelectFormFieldType,
  selectFormFieldTypeRecord,
} from '@/schema/objects/form-field-type/select-form-field-type';
import {
  TextFormFieldType,
  textFormFieldTypeRecord,
} from '@/schema/objects/form-field-type/text-form-field-type';
import { abstractRecord } from '@/schema/sanity-type';

export type FormFieldType = TextFormFieldType | SelectFormFieldType;
export type FormFieldTypeBase = {
  _type: string;
};

export const formFieldTypeRecord = abstractRecord({
  records: [textFormFieldTypeRecord, selectFormFieldTypeRecord],
});

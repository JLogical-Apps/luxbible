import runEmailFormAction from '@/lib/form/form-action-runners/email-form-action-runner';
import runPrintFormAction from '@/lib/form/form-action-runners/print-form-action-runner';
import { FormAction } from '@/schema/objects/form-action/form-action';

export default async function runFormAction(
  formAction: FormAction,
  formName: string,
  formData: FormData,
) {
  switch (formAction._type) {
    case 'printFormAction':
      return await runPrintFormAction(formAction, formName, formData);
    case 'emailFormAction':
      return await runEmailFormAction(formAction, formName, formData);
  }
}

import { PrintFormAction } from '@/schema/objects/form-action/print-form-action';

export default async function runPrintFormAction(
  formAction: PrintFormAction,
  formName: string,
  formData: FormData,
) {
  const values = Object.fromEntries(
    Array.from(formData.entries()).filter(([key]) => !key.startsWith('$')),
  );

  console.log(
    `Received new form submission from ${formName} of ${JSON.stringify(
      values,
    )}.`,
  );
}

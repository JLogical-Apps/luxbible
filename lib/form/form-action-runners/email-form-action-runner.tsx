import { Resend } from 'resend';

import { EmailFormAction } from '@/schema/objects/form-action/email-form-action';

const resend = new Resend(process.env.RESEND_API_KEY);

export default async function runEmailFormAction(
  formAction: EmailFormAction,
  formName: string,
  formData: FormData,
) {
  const values = Object.fromEntries(
    Array.from(formData.entries()).filter(([key]) => !key.startsWith('$')),
  );
  delete values['formName'];
  delete values['formActions'];

  await sendFormInfoEmail(formAction, formName, values);
}

async function sendFormInfoEmail(
  formAction: EmailFormAction,
  formName: string,
  values: Record<string, any>,
) {
  await resend.emails.send({
    from: 'form-submission@jlogical.com',
    to: formAction.toAddress,
    subject: `New Form Submission for ${formName}`,
    react: <FormInfoEmailTemplate formName={formName} formData={values} />,
  });
}

function FormInfoEmailTemplate({
  formName,
  formData,
}: {
  formName: string;
  formData: Record<string, any>;
}) {
  return (
    <>
      <p>
        You have a new submission for <strong>{formName}</strong>:
      </p>
      {Object.entries(formData).map(([key, value]) => (
        <p key={key}>
          <strong>{key}</strong>: {value}
        </p>
      ))}
    </>
  );
}

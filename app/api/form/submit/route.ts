import type { NextRequest } from 'next/server';

import runFormAction from '@/lib/form/form-action-runners/form-action-runner';
import { loadForm, loadInlineForm } from '@/sanity/loader/loadQuery';

export async function POST(request: NextRequest) {
  const formData = await request.formData();

  const formType = formData.get('$FORM_TYPE') as string | undefined;
  const formId = formData.get('$FORM_ID') as string;

  const form =
    formType == 'inline'
      ? (await loadInlineForm({ id: formId })).data
      : (await loadForm({ id: formId })).data;

  if (!form) {
    throw new Error(`Unable to find Form with id ${formData.get('$FORM_ID')}`);
  }

  if (form.recaptcha) {
    const isValidated = await verifyRecaptcha({
      recaptchaToken: formData.get('$RECAPTCHA') as string | undefined,
    });
    if (!isValidated) {
      return Response.json({
        submitted: false,
        error: 'Something went wrong. Try again later.',
      });
    }
  }

  for (const formAction of form.formActions) {
    if (formAction.enabled) {
      await runFormAction(formAction, form.name, formData);
    }
  }

  return Response.json({
    submitted: true,
    error: undefined,
  });
}

async function verifyRecaptcha({
  recaptchaToken,
}: {
  recaptchaToken?: string;
}): Promise<boolean> {
  if (!recaptchaToken) {
    return false;
  }

  const recaptchaSecretKey = process.env.RECAPTCHA_SECRET_KEY;

  if (!recaptchaSecretKey) {
    throw new Error(
      'Ensure the RECAPTCHA_SECRET_KEY environment variable is set!',
    );
  }

  const response = await fetch(
    'https://www.google.com/recaptcha/api/siteverify',
    {
      method: 'POST',
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: `secret=${recaptchaSecretKey}&response=${recaptchaToken}`,
    },
  ).then((response) => response.json());

  const score = response.score;
  console.log(`The reCAPTCHA score is: ${score}`);

  return score >= 0.7;
}

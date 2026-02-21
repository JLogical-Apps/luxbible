'use client';

import { ReCaptchaProvider, useReCaptcha } from 'next-recaptcha-v3';
import React from 'react';
import { useFormState } from 'react-dom';

import { CustomPortableText } from '@/components/CustomPortableText';
import FormFieldTypeRenderer from '@/components/renderers/form-field-type/FormFieldTypeRenderer';
import IconRenderer from '@/components/renderers/IconRenderer';
import SubmitButton from '@/components/util/SubmitButton';
import { Form } from '@/schema/documents/form';

const initialState: { submitted: boolean; error?: string } = {
  submitted: false,
};

export function FormRenderer({ form }: { form: Form }) {
  if (!form.formFields) {
    return null;
  }

  if (form.recaptcha) {
    return (
      <ReCaptchaProvider reCaptchaKey={process.env.NEXT_PUBLIC_RECAPTCHA_KEY}>
        <Form form={form} />
      </ReCaptchaProvider>
    );
  } else {
    return <Form form={form} />;
  }
}

function Form({ form }: { form: Form }) {
  const [state, formAction] = useFormState(async (_, formValues) => {
    return await fetch(`/api/form/submit`, {
      method: 'POST',
      body: formValues,
    }).then((response) => response.json());
  }, initialState);

  const { executeRecaptcha } = useReCaptcha();

  if (state.submitted) {
    return (
      <div className="mx-auto">
        <CustomPortableText value={form.successMessage} />
      </div>
    );
  }

  return (
    <form
      className="flex flex-col gap-4 justify-center items-center max-w-xl mx-auto"
      action={async (e) => {
        if (form.recaptcha) {
          const recaptchaToken = await executeRecaptcha(
            `form_${form.name.replaceAll(' ', '_').toLowerCase()}`,
          );
          e.set('$RECAPTCHA', recaptchaToken);
        }

        formAction(e);
      }}
    >
      <input name="$FORM_ID" hidden readOnly value={form._id} />
      <div className="flex flex-col gap-8 items-stretch justify-center w-full">
        {form.formFields.map((formField) => {
          return (
            <div
              key={formField.name}
              className="w-full flex flex-col items-stretch"
            >
              <div className="flex flex-row justify-stretch items-center gap-2">
                {formField.icon && (
                  <span className="h-4 w-4 text-foreground-soft">
                    <IconRenderer icon={formField.icon} />
                  </span>
                )}
                <label
                  className="flex text-sm font-semibold leading-4 text-foreground"
                  htmlFor={formField.name}
                >
                  {formField.title}
                </label>
                {formField.required && <span className="text-emphasis">*</span>}
              </div>
              <FormFieldTypeRenderer
                formField={formField}
                formFieldType={formField.type}
              />
              {formField.description && (
                <p className="mt-2.5 text-sm text-foreground-soft">
                  {formField.description}
                </p>
              )}
            </div>
          );
        })}
      </div>
      {state.error && <p className="text-red-800">{state.error}</p>}
      <SubmitButton>{form.submitButtonText ?? 'Submit'}</SubmitButton>
      {form.recaptcha && (
        //https://developers.google.com/recaptcha/docs/faq#id-like-to-hide-the-recaptcha-badge.-what-is-allowed
        <p className="mt-4 md:px-12 text-foreground-soft/80 text-xs text-center">
          This site is protected by reCAPTCHA and the Google{' '}
          <a href="https://policies.google.com/privacy">Privacy Policy</a> and{' '}
          <a href="https://policies.google.com/terms">Terms of Service</a>{' '}
          apply.
        </p>
      )}
    </form>
  );
}

'use client';

import { ReCaptchaProvider, useReCaptcha } from 'next-recaptcha-v3';
import React from 'react';
import { useFormState } from 'react-dom';

import { CustomPortableText } from '@/components/CustomPortableText';
import FormFieldTypeRenderer from '@/components/renderers/form-field-type/FormFieldTypeRenderer';
import SubmitButton from '@/components/util/SubmitButton';
import { InlineForm } from '@/schema/documents/inline-form';

const initialState: { submitted: boolean; error?: string } = {
  submitted: false,
};

export function InlineFormRenderer({ form }: { form: InlineForm }) {
  if (!form.formField) {
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

function Form({ form }: { form: InlineForm }) {
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
      className="flex flex-col gap-1 justify-center items-stretch max-w-xl mx-auto"
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
      <input name="$FORM_TYPE" hidden readOnly value="inline" />
      <div className="flex flex-row items-stretch text-foreground-soft gap-1">
        <div className="flex flex-row justify-center items-center gap-2">
          <label className="sr-only w-0" htmlFor={form.formField.name}>
            {form.formField.title}
          </label>
          {form.formField.required && form.showRequiredIndicator && (
            <span className="text-emphasis">*</span>
          )}
        </div>
        <div className="flex-grow">
          <FormFieldTypeRenderer
            formField={form.formField}
            formFieldType={form.formField.type}
          />
        </div>
        {form.formField.description && (
          <p className="mt-2.5 text-sm text-foreground-soft">
            {form.formField.description}
          </p>
        )}
        <SubmitButton className="my-auto">
          {form.submitButtonText ?? 'Submit'}
        </SubmitButton>
      </div>
      {state.error && <p className="text-red-800">{state.error}</p>}
      {form.recaptcha && (
        //https://developers.google.com/recaptcha/docs/faq#id-like-to-hide-the-recaptcha-badge.-what-is-allowed
        <p className="mt-4 md:px-2 text-foreground-soft/80 text-xs text-center">
          This site is protected by reCAPTCHA and the Google{' '}
          <a href="https://policies.google.com/privacy">Privacy Policy</a> and{' '}
          <a href="https://policies.google.com/terms">Terms of Service</a>{' '}
          apply.
        </p>
      )}
    </form>
  );
}

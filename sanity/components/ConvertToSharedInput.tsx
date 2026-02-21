/* eslint-disable react/jsx-no-bind */
import { Button, Flex, studioTheme, ThemeProvider, useToast } from '@sanity/ui';
import React, { useCallback } from 'react';
import { BiCopy } from 'react-icons/bi';
import { useClient, useFormValue } from 'sanity';

export const ConvertToSharedInput = ({ type, innerField, ...props }) => {
  const client = useClient({ apiVersion: '2021-10-21' });
  const toast = useToast();

  let path = props.path as string[];
  path = path.slice(0, path.length - 1);
  const form = useFormValue(path) as { [key: string]: any };

  const onSubmit = useCallback(async () => {
    try {
      const documentValues = {
        _type: type,
        [innerField]: [form],
      };
      const document = await client.create(documentValues);
      toast.push({
        title: (
          <>
            Created Shared{' '}
            <a href={`/studio/structure/${type}/;${document._id}`}>{type}</a>!
          </>
        ),
        status: 'success',
      });
    } catch (e) {
      console.error(e);
      toast.push({
        status: 'error',
        title: `Something went wrong: ${
          e.details?.items
            ? e?.details?.items
                .map((item: any) => item?.error?.description)
                .join('; ')
            : e?.details?.description
        }`,
      });
    }
  }, [client, form, toast, type]);

  return (
    <ThemeProvider theme={studioTheme}>
      <Flex style={{ gap: '0.5em' }} align="center">
        <Button
          mode="ghost"
          type="button"
          onClick={() => onSubmit()}
          text={'Convert To Shared'}
          icon={BiCopy}
        />
      </Flex>
    </ThemeProvider>
  );
};

ConvertToSharedInput.displayName = 'ConvertToShared';

export default ConvertToSharedInput;

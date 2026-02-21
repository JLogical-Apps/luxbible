import {
  Box,
  Button,
  Card,
  Flex,
  Stack,
  Text,
  TextArea,
  TextInput,
} from '@sanity/ui';
import { useCallback, useMemo } from 'react';
import { set, useFormValue } from 'sanity';

export const AdvancedTextInputComponent = (props) => {
  const {
    elementProps,
    schemaType: { options = {} },
    value = '',
    onChange,
  } = props;
  const form = useFormValue([]) as { [key: string]: any };

  const suggestedMinLength = options.suggestedMinLength;
  const suggestedMaxLength = options.suggestedMaxLength;

  const source = options.source;
  const formSourceValue = source ? form[source] : undefined;
  const sourceValue = useMemo(() => {
    const generator = options.sourceGenerator;
    if (generator) {
      return generator(formSourceValue);
    } else {
      return formSourceValue;
    }
  }, [formSourceValue, options.sourceGenerator]);

  const generate = useCallback(() => {
    onChange(set(sourceValue));
  }, [onChange, sourceValue]);

  const multiline = options.multiline;

  return (
    <Stack space={2}>
      <Flex style={{ gap: '0.5em' }}>
        <Box flex={1}>
          {multiline && (
            <TextArea
              {...elementProps}
              placeholder={sourceValue}
              value={value}
            />
          )}
          {!multiline && (
            <TextInput
              {...elementProps}
              placeholder={sourceValue}
              value={value}
            />
          )}
        </Box>
        {source && value.length == 0 && (
          <Button
            mode="ghost"
            text="Generate"
            disabled={props.readOnly}
            type="button"
            onClick={generate}
          />
        )}
      </Flex>
      {(suggestedMinLength || suggestedMaxLength) && (
        <Text size={0}>{value.length} characters</Text>
      )}
      {suggestedMinLength && value.length < suggestedMinLength.length && (
        <Card padding={[3, 3, 4]} radius={2} shadow={1} tone="caution">
          <Text align="center" size={[1, 1, 2]}>
            {suggestedMinLength.message}
          </Text>
        </Card>
      )}
      {suggestedMaxLength && value.length > suggestedMaxLength.length && (
        <Card padding={[3, 3, 4]} radius={2} shadow={1} tone="caution">
          <Text align="center" size={[2, 2, 3]}>
            {suggestedMaxLength.message}
          </Text>
        </Card>
      )}
    </Stack>
  );
};

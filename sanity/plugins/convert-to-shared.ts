export function convertToShared({
  type,
  innerField,
}: {
  type: string;
  innerField: string;
}) {
  return {
    type: 'boolean',
    name: 'convertToShared',
    title: 'Convert to Shared',
    options: {
      convertToShared: {
        type,
        innerField,
      },
    },
  };
}

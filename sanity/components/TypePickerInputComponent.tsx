import { RemoveIcon, TransferIcon } from '@sanity/icons';
import {
  Button,
  Grid,
  Menu,
  MenuButton,
  MenuButtonProps,
  MenuItem,
} from '@sanity/ui';
import { useCallback, useId } from 'react';
import {
  ArrayOfObjectsFunctions,
  isReferenceSchemaType,
  set,
  unset,
} from 'sanity';

const POPOVER_PROPS: MenuButtonProps['popover'] = {
  constrainSize: true,
  portal: true,
  fallbackPlacements: ['top', 'bottom'],
};

function ArrayFunctions(props) {
  const menuButtonId = useId();
  const { schemaType, readOnly, children, onValueCreate, onChange } = props;

  const replaceItem = useCallback(
    (itemType: any) => {
      const item = onValueCreate(itemType);

      onChange(set([item]));
    },
    [onValueCreate, onChange],
  );

  const handleClearBtnClick = useCallback(() => {
    onChange(unset());
  }, [onChange]);

  const total = props?.value?.length || 0;
  if (total > 0) {
    if (readOnly) {
      return null;
    }

    return (
      <Grid columns={2} gap={3}>
        <MenuButton
          button={<Button icon={TransferIcon} mode="ghost" text="Replace..." />}
          id={menuButtonId || ''}
          menu={
            <Menu>
              {schemaType.of.map((memberDef, i) => {
                // Use reference icon if reference is to one schemaType only
                const referenceIcon =
                  isReferenceSchemaType(memberDef) &&
                  (memberDef.to || []).length === 1 &&
                  memberDef.to[0].icon;

                const icon =
                  memberDef.icon || memberDef.type?.icon || referenceIcon;
                return (
                  <MenuItem
                    key={i}
                    text={memberDef.title || memberDef.type?.name}
                    onClick={() => replaceItem(memberDef)}
                    icon={icon}
                  />
                );
              })}
            </Menu>
          }
          popover={POPOVER_PROPS}
        />
        <Button
          icon={RemoveIcon}
          mode="ghost"
          onClick={handleClearBtnClick}
          text="Clear"
        />
      </Grid>
    );
  }
  return <ArrayOfObjectsFunctions {...props} />;
}

export const TypePickerInputComponent = (props) => {
  const { renderDefault } = props;

  return renderDefault({ ...props, arrayFunctions: ArrayFunctions });
};

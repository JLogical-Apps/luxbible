import { Action } from '@/schema/objects/action/action';

export function getActionProps(action: Action | undefined): {
  href: string;
  [key: string]: any;
} {
  if (!action) {
    return { href: '#' };
  }

  switch (action._type) {
    case 'idAction':
      return { href: `#${action.id}` };
    case 'internalUrlAction':
      return {
        href: `${action.linkable.path}${action.id ? `#${action.id}` : ''}`,
        target: action.newTab ? '_blank' : undefined,
      };
    case 'externalUrlAction':
      return {
        href: action.url,
        target: action.newTab ? '_blank' : undefined,
      };
  }
}

export function getActionDescriptiveText(action: Action) {
  if (!action) {
    return undefined;
  }

  switch (action._type) {
    case 'internalUrlAction':
      return action.linkable.linkableText;
  }
  return null;
}

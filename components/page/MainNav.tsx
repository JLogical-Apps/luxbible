'use client';

import { clsx } from 'clsx';
import Link from 'next/link';
import * as React from 'react';

import {
  NavigationMenu,
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuTrigger,
  navigationMenuTriggerStyle,
} from '@/components/ui/NavigationMenu';
import { cn } from '@/lib/utils';
import { Settings } from '@/schema/documents/singletons/settings';

export function MainNav({ settings }: { settings: Settings }) {
  return (
    <NavigationMenu className="mr-4 hidden md:flex items-center gap-2 text-sm">
      <NavigationMenuList>
        {settings.menuItems &&
          settings.menuItems.map((menuItem) => {
            if (!menuItem.children || menuItem.children.length == 0) {
              return (
                <NavigationMenuItem key={menuItem.linkable.path}>
                  <Link href={menuItem.linkable.path} legacyBehavior passHref>
                    <NavigationMenuLink
                      className={clsx(
                        navigationMenuTriggerStyle(),
                        'no-underline',
                      )}
                    >
                      {menuItem.linkable.linkableText}
                    </NavigationMenuLink>
                  </Link>
                </NavigationMenuItem>
              );
            } else {
              return (
                <NavigationMenuItem key={menuItem.linkable.path}>
                  <NavigationMenuTrigger>
                    {menuItem.linkable.linkableText}
                  </NavigationMenuTrigger>
                  <NavigationMenuContent className="origin-top-center data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-90 right:0 absolute left-auto top-full w-auto rounded-md bg-background border shadow">
                    <ul className="flex flex-col gap-3 p-4 w-[250px]">
                      {menuItem.children.map((child) => (
                        <li key={child.path}>
                          <NavigationMenuLink
                            asChild
                            className={navigationMenuTriggerStyle()}
                          >
                            <Link
                              className={cn(
                                'block select-none space-y-1 rounded-md p-3 leading-none no-underline outline-none',
                              )}
                              title={child.linkableText}
                              href={child.path}
                            >
                              <div className="text-sm font-medium leading-none">
                                {child.linkableText}
                              </div>
                            </Link>
                          </NavigationMenuLink>
                        </li>
                      ))}
                    </ul>
                  </NavigationMenuContent>
                </NavigationMenuItem>
              );
            }
          })}
      </NavigationMenuList>
    </NavigationMenu>
  );
}

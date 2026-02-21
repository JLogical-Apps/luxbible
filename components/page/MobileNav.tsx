'use client';

import { IconMenu2 } from '@tabler/icons-react';
import Link, { LinkProps } from 'next/link';
import { useRouter } from 'next/navigation';
import * as React from 'react';

import ImageMediaRenderer from '@/components/renderers/media/ImageMediaRenderer';
import { Button } from '@/components/ui/Button';
import { Sheet, SheetContent, SheetTrigger } from '@/components/ui/Sheet';
import { cn } from '@/lib/utils';
import { Settings } from '@/schema/documents/singletons/settings';

export function MobileNav({ settings }: { settings: Settings }) {
  const [open, setOpen] = React.useState(false);

  return (
    <Sheet open={open} onOpenChange={setOpen}>
      <SheetTrigger asChild>
        <Button
          variant="ghost"
          className="mr-4 px-0 text-base hover:bg-transparent hover:text-foreground-soft focus-visible:bg-transparent focus-visible:ring-0 focus-visible:ring-offset-0 md:hidden"
        >
          <IconMenu2 />
          <span className="sr-only">Toggle Menu</span>
        </Button>
      </SheetTrigger>
      <SheetContent side="left" className="pr-0 bg-background">
        <MobileLink href="/" onOpenChange={setOpen}>
          <div className="mr-4">
            <ImageMediaRenderer
              media={settings.logo}
              style={{ width: 'auto', height: '100%' }}
              height={40}
              className=""
              priority
            />
          </div>
        </MobileLink>
        {settings.menuItems &&
          settings.menuItems.map((menuItem) => (
            <MobileLink
              key={menuItem.linkable.path}
              className="mt-4"
              href={menuItem.linkable.path}
              onOpenChange={setOpen}
            >
              {menuItem.linkable.linkableText}
            </MobileLink>
          ))}
      </SheetContent>
    </Sheet>
  );
}

interface MobileLinkProps extends LinkProps {
  onOpenChange?: (open: boolean) => void;
  children: React.ReactNode;
  className?: string;
}

function MobileLink({
  href,
  onOpenChange,
  className,
  children,
  ...props
}: MobileLinkProps) {
  const router = useRouter();
  return (
    <div className={cn(className)}>
      <Button variant="link" asChild>
        <Link
          href={href}
          onClick={() => {
            router.push(href.toString());
            onOpenChange?.(false);
          }}
          className="flex items-center"
          {...props}
        >
          {children}
        </Link>
      </Button>
    </div>
  );
}

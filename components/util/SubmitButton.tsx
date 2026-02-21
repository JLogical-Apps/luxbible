'use client';

import { ReloadIcon } from '@radix-ui/react-icons';
import { ReactNode } from 'react';
import { useFormStatus } from 'react-dom';

import { Button } from '@/components/ui/Button';

export default function SubmitButton({
  children,
  className,
}: {
  children: ReactNode;
  className?: string;
}) {
  const { pending } = useFormStatus();

  return (
    <Button type="submit" disabled={pending} className={className}>
      {pending && <ReloadIcon className="mr-2 h-4 w-4 animate-spin" />}
      {children}
    </Button>
  );
}

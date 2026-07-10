import Link from 'next/link';

import Page from '@/components/layout/Page';
import { Button } from '@/components/ui/Button';

export default function NotFound() {
  return (
    <Page>
      <div className="container flex flex-col items-center gap-6 py-32 text-center">
        <h1 className="title-lg">Page not found</h1>
        <p className="subtitle">
          The page you’re looking for doesn’t exist or has moved.
        </p>
        <Button asChild>
          <Link href="/">Back to home</Link>
        </Button>
      </div>
    </Page>
  );
}

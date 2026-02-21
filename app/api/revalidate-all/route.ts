import { revalidatePath } from 'next/cache';

import { revalidateSecret } from '@/sanity/lib/api';
import { loadLinkables } from '@/sanity/loader/loadQuery';

export const dynamic = 'force-dynamic';

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);

  // Check for secret to confirm this is a valid request
  if (searchParams.get('secret') !== revalidateSecret) {
    return Response.json({ message: 'Invalid token', status: '401' });
  }

  const linkables = await loadLinkables();

  for (const linkable of linkables.data) {
    revalidatePath(linkable.path);
  }

  return Response.json({ revalidated: true });
}

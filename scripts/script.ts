import { client } from '@/sanity/lib/client';
import { scriptToken } from '@/scripts/scriptToken';

const clientWithToken = client.withConfig({ token: scriptToken });

async function main() {
  await clientWithToken.delete({ query: '*[_type == "pet"]' });
  console.log(await clientWithToken.fetch('*'));
}

main();

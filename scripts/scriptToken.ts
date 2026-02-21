export const scriptToken = process.env.SANITY_API_SCRIPT_TOKEN;

if (!scriptToken) {
  throw new Error('Missing SANITY_API_SCRIPT_TOKEN');
}

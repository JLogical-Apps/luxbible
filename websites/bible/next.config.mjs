/** @type {import('next').NextConfig} */
const config = {
  async redirects() {
    return [
      {
        source: '/articles/focus',
        destination: '/articles/stop-getting-distracted',
        permanent: false,
      },
    ];
  },
};

export default config;

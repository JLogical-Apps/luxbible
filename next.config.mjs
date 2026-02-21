import bundleAnalyzer from '@next/bundle-analyzer';

/** @type {import('next').NextConfig} */
const config = {
  images: {
    remotePatterns: [
      { hostname: 'cdn.sanity.io' },
      { hostname: 'source.unsplash.com' },
      { hostname: 'img.youtube.com' },
      { hostname: 'i.vimeocdn.com' }
    ],
    deviceSizes: [425, 640, 750, 828, 1080, 1200, 1920, 2048, 3840]
  },
  logging: {
    fetches: {
      fullUrl: true
    }
  },
  experimental: {
    taint: true
  },
  async rewrites() {
    return [
      {
        source: '/robots.txt',
        destination: '/api/robots'
      }
    ];
  }
};

const withBundleAnalyzer = bundleAnalyzer({
  enabled: process.env.ANALYZE === 'true'
});

export default withBundleAnalyzer(config);
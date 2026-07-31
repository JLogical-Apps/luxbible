import '@/styles/globals.css';

import { Metadata, Viewport } from 'next';
import { Bitter, Inter } from 'next/font/google';
import Script from 'next/script';
import React from 'react';

import { site } from '@/lib/site';

const serif = Bitter({
  variable: '--font-serif',
  style: ['normal', 'italic'],
  subsets: ['latin'],
  weight: ['400', '700'],
});
const sans = Inter({
  variable: '--font-sans',
  subsets: ['latin'],
  weight: ['500', '700'],
});

export const viewport: Viewport = {
  themeColor: '#09090b',
};

export const metadata: Metadata = {
  metadataBase: new URL(site.domain),
  title: {
    default: `${site.name} • ${site.tagline}`,
    template: `%s • ${site.name}`,
  },
  description: site.description,
  openGraph: {
    title: `${site.name} • ${site.tagline}`,
    description: site.description,
    url: site.domain,
    siteName: site.name,
    type: 'website',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const gaId = process.env.NEXT_PUBLIC_GA_ID;
  return (
    <html lang="en" className={`${sans.variable} ${serif.variable}`}>
      <body>
        {children}
        {process.env.NODE_ENV === 'production' && gaId && (
          <>
            <Script
              async
              src={`https://www.googletagmanager.com/gtag/js?id=${gaId}`}
            />
            <Script id="google-analytics">
              {`window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());
                gtag('config', '${gaId}');`}
            </Script>
          </>
        )}
      </body>
    </html>
  );
}

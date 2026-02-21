import '@/styles/globals.css';

import { Viewport } from 'next';
import { Bitter, Inter } from 'next/font/google';
import Script from 'next/script';
import React from 'react';

import Providers from '@/app/(pages)/providers';

export const viewport: Viewport = {
  themeColor: '#000',
};

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

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${sans.variable} ${serif.variable}`}>
      <body>
        <Providers>{children}</Providers>
        {process.env.NODE_ENV == 'production' && (
          <>
            <Script
              async
              src={`https://www.googletagmanager.com/gtag/js?id=${process.env.NEXT_PUBLIC_GA_ID}`}
            />
            <Script id="google-analytics">
              {`window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());

                gtag('config', '${process.env.NEXT_PUBLIC_GA_ID}');`}
            </Script>
          </>
        )}
      </body>
    </html>
  );
}

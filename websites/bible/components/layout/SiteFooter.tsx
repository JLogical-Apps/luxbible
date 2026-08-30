import {
  IconBrandFacebook,
  IconBrandInstagram,
  IconBrandTiktok,
  IconBrandYoutube,
  IconMail,
} from '@tabler/icons-react';
import Link from 'next/link';

import { getArticleHref, noteTakingArticle, soapArticle } from '@/lib/articles';
import { site } from '@/lib/site';

const footerColumns = [
  {
    title: 'Lux Bible',
    href: '/',
    links: [
      { name: 'Built for Readers', href: '/#built-for-readers' },
      { name: 'Built for Note-takers', href: '/#built-for-note-takers' },
      { name: 'Built for Studiers', href: '/#built-for-studiers' },
      { name: 'Tips and Updates', href: '/#tips-and-updates' },
      { name: 'Download', href: '/#download' },
      { name: 'Community', href: '/#community' },
    ],
  },
  {
    title: 'Articles',
    href: '/articles',
    links: [soapArticle, noteTakingArticle].map((article) => ({
      name: article.shortName,
      href: getArticleHref(article),
    })),
  },
  {
    title: 'Legal',
    href: undefined,
    links: [{ name: 'Privacy Policy', href: '/privacy-policy' }],
  },
];

const socials = [
  {
    name: 'Instagram',
    href: site.social.instagram,
    color: '#ec4899',
    icon: <IconBrandInstagram />,
  },
  {
    name: 'Facebook',
    href: site.social.facebook,
    color: '#1877f2',
    icon: <IconBrandFacebook />,
  },
  {
    name: 'YouTube',
    href: site.social.youtube,
    color: '#ff0000',
    icon: <IconBrandYoutube />,
  },
  {
    name: 'TikTok',
    href: site.social.tiktok,
    color: '#25f4ee',
    icon: <IconBrandTiktok />,
  },
  {
    name: 'Email',
    href: `mailto:${site.social.email}`,
    color: '#f59e0b',
    icon: <IconMail />,
  },
];

export default function SiteFooter() {
  return (
    <>
      <div className="h-px w-full bg-foreground-soft/20" />
      <footer className="w-full bg-background py-8 px-4 md:px-6 lg:px-10">
        <div className="container mx-auto grid gap-12 py-4 lg:grid-cols-[minmax(12rem,1fr)_3fr]">
          <div className="flex flex-col items-start gap-4">
            <Link href="/" className="no-underline">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              <img
                src="/media/lux-logo.svg"
                alt={`${site.name} logo`}
                className="grayscale transition hover:grayscale-0"
                style={{ width: 'auto', height: '40px' }}
              />
            </Link>
            <p className="text-sm text-foreground-soft">
              {site.name} © {new Date().getFullYear()}
            </p>
            <div className="flex flex-row gap-2 text-sm">
              {socials.map((s) => (
                <div
                  key={s.name}
                  style={{ ['--icon-hover' as string]: s.color }}
                >
                  <Link
                    href={s.href}
                    target={s.href.startsWith('mailto:') ? undefined : '_blank'}
                    className="text-foreground-soft hover:text-[var(--icon-hover)]"
                    aria-label={s.name}
                  >
                    <span className="h-6 w-6">{s.icon}</span>
                  </Link>
                </div>
              ))}
            </div>
          </div>

          <nav
            aria-label="Footer"
            className="grid grid-cols-2 gap-x-6 gap-y-10 sm:grid-cols-3"
          >
            {footerColumns.map(({ title, href, links }) => (
              <div key={title}>
                <h2 className="font-semibold text-foreground">
                  {href ? <Link href={href}>{title}</Link> : title}
                </h2>
                <ul className="mt-4 space-y-3 text-sm text-foreground-soft">
                  {links.map(({ name, href }) => (
                    <li key={href}>
                      <Link href={href}>{name}</Link>
                    </li>
                  ))}
                </ul>
              </div>
            ))}
          </nav>
        </div>
      </footer>
    </>
  );
}

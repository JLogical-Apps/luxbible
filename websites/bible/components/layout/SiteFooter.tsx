import {
  IconBrandFacebook,
  IconBrandInstagram,
  IconBrandTiktok,
  IconBrandYoutube,
  IconMail,
} from '@tabler/icons-react';
import Link from 'next/link';

import { site } from '@/lib/site';

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
        <div className="container mx-auto flex flex-col-reverse items-center justify-between gap-6 gap-y-12 lg:flex-row">
          <div className="flex flex-col items-center gap-4">
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
        </div>
      </footer>
    </>
  );
}

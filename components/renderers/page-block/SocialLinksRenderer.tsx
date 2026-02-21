import {
  IconBrandFacebook,
  IconBrandInstagram,
  IconBrandLinkedin,
  IconBrandTwitter,
  IconBrandYoutube,
  IconMail,
} from '@tabler/icons-react';
import Link from 'next/link';
import { ReactElement } from 'react';

import { HasSocialLinks } from '@/schema/mixins/has-social-links';

type SocialType = keyof HasSocialLinks;

const socialTypeInfo: Record<
  SocialType,
  {
    name: string;
    color: string;
    icon: ReactElement;
  }
> = {
  facebook: {
    name: 'Facebook',
    color: '#2563eb',
    icon: <IconBrandFacebook />,
  },
  instagram: {
    name: 'Instagram',
    color: '#ec4899',
    icon: <IconBrandInstagram />,
  },
  twitter: {
    name: 'Twitter',
    color: '#60a5fa',
    icon: <IconBrandTwitter />,
  },
  youTube: {
    name: 'YouTube',
    color: '#dc2626',
    icon: <IconBrandYoutube />,
  },
  linkedIn: {
    name: 'LinkedIn',
    color: '#1d4ed8',
    icon: <IconBrandLinkedin />,
  },
  email: {
    name: 'Email',
    color: '#f59e0b',
    icon: <IconMail />,
  },
};

export default function SocialLinksRenderer({
  socialLinks,
  includeEmail = true,
}: {
  socialLinks: HasSocialLinks;
  includeEmail?: boolean;
}) {
  return (
    <>
      {Object.keys(socialTypeInfo).map((type) => {
        const socialTypeKey = type as SocialType;
        if (socialTypeKey === 'email' && !includeEmail) {
          return null;
        }

        const url = socialLinks[socialTypeKey];
        return url && <SocialLink key={type} url={url} type={socialTypeKey} />;
      })}
    </>
  );
}

function SocialLink({ url, type }: { url: string; type: SocialType }) {
  return (
    <div style={{ ['--icon-hover' as any]: socialTypeInfo[type].color }}>
      <Link
        href={type === 'email' ? `mailto:${url}` : url}
        target="_blank"
        className="text-foreground-soft hover:text-[var(--icon-hover)]"
      >
        <span className="h-6 w-6">{socialTypeInfo[type].icon}</span>
        <span className="sr-only">{socialTypeInfo[type].name}</span>
      </Link>
    </div>
  );
}

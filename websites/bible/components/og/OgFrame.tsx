import { ReactNode } from 'react';

import { getLuxLogoSrc, ogColors } from '@/lib/og';
import { site } from '@/lib/site';

export default function OgFrame({ children }: { children: ReactNode }) {
  return (
    <div
      style={{
        display: 'flex',
        flexDirection: 'column',
        width: '100%',
        height: '100%',
        padding: '64px 72px',
        backgroundColor: ogColors.background,
        backgroundImage: `radial-gradient(circle at 100% 100%, rgba(250, 204, 21, 0.16), rgba(250, 204, 21, 0) 60%)`,
        color: ogColors.foreground,
        fontFamily: 'Inter',
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: 20 }}>
        <img src={getLuxLogoSrc()} width={56} height={56} alt="" />
        <div style={{ fontSize: 30, color: ogColors.muted }}>{site.name}</div>
      </div>
      {children}
    </div>
  );
}

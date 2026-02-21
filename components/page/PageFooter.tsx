import Link from 'next/link';
import * as React from 'react';

import { InlineFormRenderer } from '@/components/renderers/InlineFormRenderer';
import ImageMediaRenderer from '@/components/renderers/media/ImageMediaRenderer';
import SocialLinksRenderer from '@/components/renderers/page-block/SocialLinksRenderer';
import { Separator } from '@/components/ui/Separator';
import { getColorPaletteVariables } from '@/schema/documents/design/color-palette';
import { Settings } from '@/schema/documents/singletons/settings';

export default function PageFooter({ settings }: { settings: Settings }) {
  const colorPaletteVariables = settings.footerColorPalette
    ? getColorPaletteVariables(settings.footerColorPalette)
    : {};

  return (
    <>
      <Separator className="bg-foreground-soft/20" />
      <footer
        className="w-full bg-background py-8 px-4 md:px-6 lg:px-10"
        style={colorPaletteVariables}
      >
        <div className="container mx-auto flex flex-col-reverse lg:flex-row items-center justify-between gap-6 gap-y-12">
          <div className="flex flex-col items-center gap-4">
            <a href="/">
              <ImageMediaRenderer
                media={settings.logo}
                className="grayscale hover:grayscale-0"
                height={40}
                style={{ width: 'auto', height: 40 }}
              />
            </a>
            {settings.brandName && (
              <p className="text-sm text-foreground-soft">
                {settings.brandName} © {new Date().getFullYear()}
              </p>
            )}
            <div className="flex flex-row gap-2 text-sm">
              <SocialLinksRenderer socialLinks={settings} />
            </div>
          </div>
          <div className="flex flex-col flex-grow justify-center items-center gap-8">
            {settings.footerItems && settings.footerItems.length > 0 && (
              <nav className="flex flex-wrap justify-center px-6 gap-4 md:gap-6 mt-4 md:mt-0">
                {settings.footerItems.map((footerItem) => (
                  <Link
                    key={footerItem.linkable.path}
                    className="text-sm text-foreground-soft no-underline hover:underline"
                    href={footerItem.linkable.path}
                  >
                    {footerItem.linkable.linkableText}
                  </Link>
                ))}
              </nav>
            )}
            {settings.builtByImage && (
              <div className="flex flex-wrap items-center justify-center px-6 mt-4 md:mt-0">
                <p className="text-sm text-foreground-soft mr-2">Built by </p>
                {settings.builtByLink ? (
                  <a href={settings.builtByLink} target="_blank">
                    <ImageMediaRenderer
                      className="grayscale hover:grayscale-0"
                      height={30}
                      style={{ width: 'auto', height: 30 }}
                      media={settings.builtByImage}
                    />
                  </a>
                ) : (
                  <ImageMediaRenderer
                    className="grayscale"
                    height={30}
                    style={{ width: 'auto', height: 30 }}
                    media={settings.builtByImage}
                  />
                )}
              </div>
            )}
          </div>
          {settings.newsletterForm && (
            <div className="flex flex-col items-center justify-center gap-2 lg:basis-[400px]">
              <p className="text-sm text-foreground-soft text-center">
                {settings.newsletterTitle ?? 'Join The Newsletter'}
              </p>
              <p className="text-xs text-foreground-soft text-start">
                {settings.newsletterBody ??
                  'For exclusive updates, sign up for the newsletter.'}
              </p>
              <InlineFormRenderer form={settings.newsletterForm} />
            </div>
          )}
        </div>
      </footer>
    </>
  );
}

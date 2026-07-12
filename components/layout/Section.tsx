import { CSSProperties, ReactNode } from 'react';

import DotsBackground from '@/components/backgrounds/DotsBackground';
import GridBackground from '@/components/backgrounds/GridBackground';
import { cn } from '@/lib/utils';

type Align = 'start' | 'center' | 'responsive';

// Full literal class strings so Tailwind can detect them.
const alignClasses: Record<Align, string> = {
  center: 'text-center justify-center items-center',
  start: 'text-start justify-start items-start',
  responsive:
    'text-start sm:text-center justify-start sm:justify-center items-start sm:items-center',
};

export default function Section({
  id,
  background,
  contained = false,
  align = 'center',
  titleSize = 'md',
  useH1 = false,
  tagline,
  title,
  subtitle,
  children,
  mediaBelow,
  paletteVars,
}: {
  id?: string;
  background?: 'dots';
  contained?: boolean;
  align?: Align;
  titleSize?: 'md' | 'lg';
  useH1?: boolean;
  tagline?: ReactNode;
  title?: ReactNode;
  subtitle?: ReactNode;
  children?: ReactNode;
  mediaBelow?: ReactNode;
  paletteVars?: CSSProperties;
}) {
  const heading =
    titleSize === 'lg' || useH1 ? (
      <h1 className={titleSize === 'lg' ? 'title-lg' : 'title'}>{title}</h1>
    ) : (
      <p className="title">{title}</p>
    );

  const body = (
    <>
      {(tagline || title || subtitle) && (
        <div className="flex items-center justify-center gap-4 md:gap-8 px-2 mx-auto flex-wrap flex-row">
          <div
            className={cn(
              alignClasses[align],
              'max-w-4xl flex-grow basis-[380px]',
            )}
          >
            {tagline && (
              <p className="font-semibold leading-7 text-foreground-soft">
                {tagline}
              </p>
            )}
            {title && heading}
            {subtitle && <p className="mt-6 subtitle">{subtitle}</p>}
          </div>
        </div>
      )}
      {children && <div className="mt-12 sm:mt-16">{children}</div>}
      {mediaBelow && (
        <div className="mx-auto mt-16 max-w-6xl basis-[56rem]">
          {mediaBelow}
        </div>
      )}
    </>
  );

  const inner = (
    <div className="container py-16 lg:py-20 xl:py-24">
      {contained ? (
        <GridBackground className="palette-light rounded-3xl px-4 md:px-6 pt-16 pb-4 w-full">
          {body}
        </GridBackground>
      ) : (
        body
      )}
    </div>
  );

  return (
    <section id={id} style={paletteVars}>
      {background === 'dots' ? <DotsBackground>{inner}</DotsBackground> : inner}
    </section>
  );
}

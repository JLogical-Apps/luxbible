import { ReactNode } from 'react';

import DotsBackgroundRenderer from '@/components/renderers/background/DotsBackgroundRenderer';
import FillBackgroundRenderer from '@/components/renderers/background/FillBackgroundRenderer';
import GradientBackgroundRenderer from '@/components/renderers/background/GradientBackgroundRenderer';
import GridBackgroundRenderer from '@/components/renderers/background/GridBackgroundRenderer';
import { Background } from '@/schema/objects/background/background-record';

export default function BackgroundRenderer({
  background,
  children,
  className,
}: {
  background?: Background;
  children: ReactNode;
  className?: string;
}) {
  if (!background) {
    return children;
  }

  switch (background._type) {
    case 'fillBackground':
      return (
        <FillBackgroundRenderer background={background} className={className}>
          {children}
        </FillBackgroundRenderer>
      );
    case 'gradientBackground':
      return (
        <GradientBackgroundRenderer
          background={background}
          className={className}
        >
          {children}
        </GradientBackgroundRenderer>
      );
    case 'gridBackground':
      return (
        <GridBackgroundRenderer background={background} className={className}>
          {children}
        </GridBackgroundRenderer>
      );
    case 'dotsBackground':
      return (
        <DotsBackgroundRenderer background={background} className={className}>
          {children}
        </DotsBackgroundRenderer>
      );
  }
}

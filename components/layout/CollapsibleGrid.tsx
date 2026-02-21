import { Property } from 'csstype';
import { ReactNode } from 'react';

export default function CollapsibleGrid({
  children,
  alignItems = 'start',
}: {
  children: ReactNode[];
  alignItems?: Property.AlignItems | undefined;
}) {
  return (
    <div
      className="flex flex-wrap justify-evenly gap-12 gap-y-16 mx-auto px-2 md:px-6 lg:px-8"
      style={{ alignItems: alignItems }}
    >
      {children.map((child, i) => (
        <div key={i} className="flex-grow max-w-[500px] basis-[340px]">
          {child}
        </div>
      ))}
    </div>
  );
}

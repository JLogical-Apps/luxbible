import { ReactNode } from 'react';

export default function Prose({ children }: { children: ReactNode }) {
  return (
    <div className="prose prose-invert max-w-none prose-a:text-emphasis prose-headings:scroll-mt-24 prose-headings:font-serif prose-h2:border-b prose-h2:border-background-soft prose-h2:pb-4 prose-h2:text-3xl prose-h2:leading-tight prose-h3:border-l-2 prose-h3:border-emphasis prose-h3:pl-4 prose-h3:text-xl prose-h3:leading-snug sm:prose-h2:text-4xl sm:prose-h3:text-2xl">
      {children}
    </div>
  );
}

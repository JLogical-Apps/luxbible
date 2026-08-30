'use client';

import { useEffect, useState } from 'react';

export type ArticleTableOfContentsItem = {
  id: string;
  label: string;
  level?: 2 | 3;
};

export default function ArticleTableOfContents({
  items,
}: {
  items: ArticleTableOfContentsItem[];
}) {
  const [activeId, setActiveId] = useState(items[0]?.id);

  useEffect(() => {
    const headings = items
      .map(({ id }) => document.getElementById(id))
      .filter((heading): heading is HTMLElement => heading !== null);

    const updateActiveHeading = () => {
      const readingLine = Math.min(200, window.innerHeight * 0.25);
      const activeHeading = headings.reduce(
        (active, heading) =>
          heading.getBoundingClientRect().top <= readingLine ? heading : active,
        headings[0],
      );

      setActiveId(activeHeading?.id);
    };

    updateActiveHeading();
    window.addEventListener('scroll', updateActiveHeading, { passive: true });
    window.addEventListener('resize', updateActiveHeading);

    return () => {
      window.removeEventListener('scroll', updateActiveHeading);
      window.removeEventListener('resize', updateActiveHeading);
    };
  }, [items]);

  return (
    <nav
      aria-label="Article table of contents"
      className="sticky top-24 max-h-[calc(100vh-8rem)] overflow-y-auto pr-2"
    >
      <p className="mb-4 text-xs font-semibold uppercase tracking-[0.16em] text-foreground-soft">
        Contents
      </p>
      <ol className="space-y-1">
        {items.map(({ id, label, level = 2 }) => {
          const isActive = activeId === id;

          return (
            <li key={id}>
              <a
                href={`#${id}`}
                aria-current={isActive ? 'location' : undefined}
                onClick={() => setActiveId(id)}
                className={`block border-l-2 py-1.5 text-sm leading-5 no-underline transition-colors ${
                  level === 3 ? 'pl-6' : 'pl-3'
                } ${
                  isActive
                    ? 'border-emphasis font-semibold text-emphasis'
                    : 'border-transparent text-foreground-soft hover:border-foreground-soft hover:text-foreground'
                }`}
              >
                {label}
              </a>
            </li>
          );
        })}
      </ol>
    </nav>
  );
}

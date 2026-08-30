'use client';

import Image from 'next/image';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { useEffect, useRef, useState } from 'react';

import { Article, getArticleHref } from '@/lib/articles';
import { cn } from '@/lib/utils';

export default function ArticleCard({ article }: { article: Article }) {
  const href = getArticleHref(article);
  const router = useRouter();
  const [isTouchFocused, setIsTouchFocused] = useState(false);
  const isTouchInteraction = useRef(false);
  const card = useRef<HTMLAnchorElement>(null);

  useEffect(() => {
    const handlePointerDown = (event: PointerEvent) => {
      if (!card.current?.contains(event.target as Node)) {
        setIsTouchFocused(false);
      }
    };

    document.addEventListener('pointerdown', handlePointerDown);
    return () => document.removeEventListener('pointerdown', handlePointerDown);
  }, []);

  return (
    <Link
      ref={card}
      href={href}
      className={cn(
        'article-card relative block aspect-[40/21] overflow-hidden rounded-2xl bg-background-soft no-underline focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-emphasis',
        isTouchFocused && 'article-card-touch-focused',
      )}
      onPointerDown={(event) => {
        isTouchInteraction.current = event.pointerType === 'touch';
      }}
      onClick={(event) => {
        if (!isTouchInteraction.current || event.detail === 0) return;

        event.preventDefault();

        if (isTouchFocused) {
          router.push(href);
          return;
        }

        setIsTouchFocused(true);
        event.currentTarget.focus();
      }}
    >
      <Image
        src={article.thumbnail}
        alt=""
        fill
        sizes="(min-width: 768px) 50vw, 100vw"
        className="article-card-thumbnail object-cover"
      />
      <div className="article-card-overlay absolute inset-0 flex flex-col justify-end bg-black/90 p-5 text-white sm:p-7">
        <p className="article-card-touch-hint mb-2 text-xs font-bold uppercase tracking-widest text-emphasis">
          Tap again to open
        </p>
        <h2 className="line-clamp-2 font-serif text-xl font-bold sm:text-2xl">
          {article.title}
        </h2>
        <p className="mt-3 line-clamp-2 text-sm leading-6 text-zinc-200 sm:text-base">
          {article.description}
        </p>
      </div>
    </Link>
  );
}

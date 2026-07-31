import { IconBrandInstagram, IconPlayerPlayFilled } from '@tabler/icons-react';

type BeholdMediaSize = {
  mediaUrl: string;
};

type BeholdPost = {
  id: string;
  timestamp: string;
  permalink: string;
  mediaType: 'IMAGE' | 'VIDEO' | 'CAROUSEL_ALBUM';
  mediaUrl: string;
  thumbnailUrl?: string;
  sizes?: {
    medium?: BeholdMediaSize;
  };
  caption?: string;
  prunedCaption?: string;
  altText?: string;
};

type BeholdFeed = {
  posts: BeholdPost[];
};

type InstagramPost = {
  id: string;
  caption: string;
  imageUrl: string;
  permalink: string;
  isVideo: boolean;
};

const instagramRevalidateSeconds = 60 * 60 * 24;

function postPermalink(permalink: string) {
  const url = new URL(permalink);
  url.pathname = url.pathname.replace(/^\/reel\//, '/p/');
  return url.toString();
}

async function getInstagramPosts(): Promise<InstagramPost[]> {
  const feedId = process.env.BEHOLD_FEED_ID;

  if (!feedId) {
    return [];
  }

  const response = await fetch(
    `https://feeds.behold.so/${encodeURIComponent(feedId)}`,
    {
      next: { revalidate: instagramRevalidateSeconds },
    },
  );

  if (!response.ok) {
    throw new Error('Instagram feed is unavailable.');
  }

  const { posts } = (await response.json()) as BeholdFeed;

  return [...posts]
    .sort((a, b) => (b.timestamp ?? '').localeCompare(a.timestamp ?? ''))
    .map((post): InstagramPost | null => {
      const imageUrl =
        post.sizes?.medium?.mediaUrl ??
        (post.mediaType === 'VIDEO' ? post.thumbnailUrl : post.mediaUrl);

      if (!imageUrl) {
        return null;
      }

      return {
        id: post.id,
        caption: post.altText ?? post.prunedCaption ?? post.caption ?? '',
        imageUrl,
        permalink: postPermalink(post.permalink),
        isVideo: post.mediaType === 'VIDEO',
      };
    })
    .filter((post): post is InstagramPost => post !== null)
    .slice(0, 6);
}

export default async function InstagramFeed() {
  const posts = await getInstagramPosts();

  if (posts.length === 0) {
    return null;
  }

  return (
    <div className="grid grid-cols-3 gap-4 lg:grid-cols-6">
      {posts.map((post) => (
        <a
          key={post.id}
          href={post.permalink}
          target="_blank"
          rel="noreferrer"
          className="group relative aspect-[9/16] overflow-hidden rounded-2xl bg-background-soft"
          aria-label={`Open Instagram post${
            post.caption ? `: ${post.caption}` : ''
          }`}
        >
          {/* eslint-disable-next-line @next/next/no-img-element */}
          <img
            src={post.imageUrl}
            alt={post.caption || 'Lux Bible Instagram post'}
            className="h-full w-full object-cover transition duration-300 group-hover:scale-105"
          />
          <div className="absolute inset-0 bg-gradient-to-t from-black/65 via-transparent to-transparent opacity-80" />
          <div className="absolute bottom-3 left-3 flex items-center gap-2 text-sm font-bold text-white">
            {post.isVideo ? (
              <IconPlayerPlayFilled size={18} />
            ) : (
              <IconBrandInstagram size={18} />
            )}
            <span>{post.isVideo ? 'Watch Reel' : 'View post'}</span>
          </div>
        </a>
      ))}
    </div>
  );
}

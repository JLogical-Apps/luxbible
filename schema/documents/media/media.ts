import {
  ImageMedia,
  imageMediaRecord,
} from '@/schema/documents/media/image-media';
import {
  VideoMedia,
  videoMediaRecord,
} from '@/schema/documents/media/video-media';
import {
  VimeoMedia,
  vimeoMediaRecord,
} from '@/schema/documents/media/vimeo-media';
import {
  YouTubeMedia,
  youtubeMediaRecord,
} from '@/schema/documents/media/youtube-media';
import { abstractRecord } from '@/schema/sanity-type';

export type Media = ImageMedia | VideoMedia | YouTubeMedia | VimeoMedia;

export interface MediaBase {
  _type: string;
}

export const mediaRecord = abstractRecord({
  records: [
    imageMediaRecord,
    videoMediaRecord,
    youtubeMediaRecord,
    vimeoMediaRecord,
  ],
});

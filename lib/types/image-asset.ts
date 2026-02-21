export interface ImageAsset {
  _id?: string;
  url?: string;
  path?: string;
  assetId?: string;
  extension?: string;
  metadata: {
    lqip: string;
    dimensions: {
      width: number;
      height: number;
      aspectRatio: number;
    };
  };
}

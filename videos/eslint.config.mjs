import { config } from "@remotion/eslint-config-flat";

export default [
  ...config,
  {
    files: ["src/videos/**/video.ts"],
    rules: { "@remotion/non-pure-animation": "off" },
  },
];

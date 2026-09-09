export const getFrames = (seconds: number, fps: number) =>
  Math.round(seconds * fps);

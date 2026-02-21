export type HslColor = {
  h: number;
  s: number;
  l: number;
};

export function computeHslAttribute(color: HslColor) {
  return `${color.h} ${color.s * 100}% ${color.l * 100}%`;
}

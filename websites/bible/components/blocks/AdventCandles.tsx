import { useId } from 'react';

// A static version of AdventCandlesPainter in the app, in the same proportions and colors.
const candleCount = 4;
const width = 70;
const height = 60;
const candleWidth = width / (candleCount * 2 - 1);
const top = height * 0.35;
const flameHeight = height * 0.32;

const getFlamePath = (
  centerX: number,
  {
    tip,
    shoulder,
    hip,
    base,
    shoulderWidth,
    hipWidth,
  }: Record<
    'tip' | 'shoulder' | 'hip' | 'base' | 'shoulderWidth' | 'hipWidth',
    number
  >,
) => {
  const y = (fraction: number) => top - flameHeight * fraction;
  const x = (fraction: number) => candleWidth * fraction;
  return [
    `M ${centerX} ${y(tip)}`,
    `C ${centerX + x(shoulderWidth)} ${y(shoulder)} ${
      centerX + x(hipWidth)
    } ${y(hip)} ${centerX} ${y(base)}`,
    `C ${centerX - x(hipWidth)} ${y(hip)} ${centerX - x(shoulderWidth)} ${y(
      shoulder,
    )} ${centerX} ${y(tip)}`,
    'Z',
  ].join(' ');
};

const mixColors = (from: string, to: string, amount: number) => {
  const getChannels = (hex: string) =>
    [1, 3, 5].map((start) => parseInt(hex.slice(start, start + 2), 16));
  const [fromChannels, toChannels] = [getChannels(from), getChannels(to)];
  return `rgb(${fromChannels
    .map((channel, index) =>
      Math.round(channel + (toChannels[index] - channel) * amount),
    )
    .join(' ')})`;
};

export default function AdventCandles({
  litCount,
  className,
}: {
  litCount: number;
  className?: string;
}) {
  const glowId = useId();
  return (
    <svg
      viewBox={`-8 -14 ${width + 16} ${height + 22}`}
      overflow="visible"
      className={className}
      aria-hidden
    >
      <defs>
        <radialGradient id={glowId}>
          <stop offset="0%" stopColor="#FCD34D" stopOpacity={0.5} />
          <stop offset="100%" stopColor="#FCD34D" stopOpacity={0} />
        </radialGradient>
      </defs>
      {Array.from({ length: candleCount }, (_, index) => {
        const isLit = index < litCount;
        const centerX = index * candleWidth * 2 + candleWidth / 2;
        return (
          <g key={index}>
            {isLit && (
              <>
                <circle
                  cx={centerX}
                  cy={top - flameHeight * 0.45}
                  r={flameHeight * 1.3}
                  fill={`url(#${glowId})`}
                />
                <path
                  d={getFlamePath(centerX, {
                    tip: 1,
                    shoulder: 0.5,
                    hip: 0.1,
                    base: 0.08,
                    shoulderWidth: 0.6,
                    hipWidth: 0.45,
                  })}
                  fill="#FACC15"
                />
                <path
                  d={getFlamePath(centerX, {
                    tip: 0.6,
                    shoulder: 0.4,
                    hip: 0.15,
                    base: 0.12,
                    shoulderWidth: 0.25,
                    hipWidth: 0.2,
                  })}
                  fill="#FFF7ED"
                />
              </>
            )}
            <rect
              x={centerX - candleWidth / 2}
              y={top}
              width={candleWidth}
              height={height - top}
              rx={candleWidth * 0.25}
              fill={isLit ? '#FEF3C7' : '#D6D3D1'}
              fillOpacity={isLit ? 1 : 0.4}
            />
          </g>
        );
      })}
      <rect
        x={-candleWidth * 0.6}
        y={height - candleWidth * 0.3}
        width={width + candleWidth * 1.2}
        height={candleWidth * 0.7}
        rx={candleWidth * 0.35}
        fill={mixColors('#57534E', '#CA8A04', litCount / candleCount)}
      />
    </svg>
  );
}

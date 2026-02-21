import { clsx } from 'clsx';
import { ReactElement, useCallback, useState } from 'react';

export default function PlayerFacade({
  className,
  placeholder,
  playerBuilder,
  playButton,
  aspectRatio,
}: {
  className?: string;
  placeholder: ReactElement;
  playerBuilder: () => ReactElement;
  playButton: (isHovering: boolean) => ReactElement;
  aspectRatio?: string;
}) {
  const [player, setPlayer] = useState<ReactElement | undefined>();
  const [isHovering, setIsHovering] = useState(false);

  const handleClick = useCallback(
    () => setPlayer(playerBuilder()),
    [playerBuilder],
  );

  const handleHover = useCallback(
    (hovering: boolean) => setIsHovering(hovering),
    [],
  );

  if (player) {
    return (
      <>
        <div
          className={clsx('relative w-full', className)}
          style={{ aspectRatio: aspectRatio ?? '16/9' }}
        >
          {player}
        </div>
      </>
    );
  }

  return (
    <div
      className={clsx('relative cursor-pointer w-full', className)}
      style={{ aspectRatio: aspectRatio ?? '16/9' }}
      onClick={handleClick}
      onMouseEnter={() => handleHover(true)}
      onMouseLeave={() => handleHover(false)}
    >
      {placeholder}
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2">
        {playButton(isHovering)}
      </div>
    </div>
  );
}

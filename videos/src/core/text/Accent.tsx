import type { ReactNode } from "react";

export const Accent: React.FC<{ children: ReactNode; color: string }> = ({
  children,
  color,
}) => <span style={{ color }}>{children}</span>;

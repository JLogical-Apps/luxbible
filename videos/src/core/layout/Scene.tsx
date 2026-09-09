import { Interactive } from "remotion";
import type { ReactNode } from "react";

export const Scene: React.FC<{ children: ReactNode }> = ({ children }) => (
  <Interactive.Div
    name="Scene content"
    style={{ position: "absolute", inset: 0, overflow: "hidden" }}
  >
    {children}
  </Interactive.Div>
);

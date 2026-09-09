import { createContext, useContext, type ReactNode } from "react";

const MotionSpeedContext = createContext(1);

export const MotionProvider: React.FC<{
  children: ReactNode;
  speed: number;
}> = ({ children, speed }) => (
  <MotionSpeedContext.Provider value={speed}>
    {children}
  </MotionSpeedContext.Provider>
);

export const useMotionSpeed = () => useContext(MotionSpeedContext);

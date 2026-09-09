import "./index.css";
import { Composition } from "remotion";
import { SoapVideo } from "./videos/soap/SoapVideo";
import { soapVideoSchema } from "./videos/soap/schema";
import { calculateSoapVideoMetadata } from "./videos/soap/metadata";

export const RemotionRoot: React.FC = () => (
  <Composition
    id="SoapBibleStudy"
    component={SoapVideo}
    durationInFrames={2761}
    fps={30}
    width={1080}
    height={1920}
    schema={soapVideoSchema}
    calculateMetadata={calculateSoapVideoMetadata}
    defaultProps={{
      accentColor: "#ffca18",
      redColor: "#f04444",
      textColor: "#f7f5ef",
      shaderColor1: "#161512",
      shaderColor2: "#1d2320",
      shaderColor3: "#30352f",
      shaderColor4: "#090a0a",
      motionSpeed: 0.65,
      shaderSpeed: 0.55,
      shaderTransitionSpeed: 1.5,
      shaderTransitionLeadSeconds: 0.65,
      shaderTransitionTrailSeconds: 0.2,
      shaderTransitionEaseSeconds: 0.3,
      shaderDistortion: 0.3,
      shaderSwirl: 0.1,
      shaderDarkness: 0.15,
      fontScale: 1,
      imageScale: 1,
      whipBlur: 24,
    }}
  />
);

import "./index.css";
import { Composition } from "remotion";
import { SoapVideo } from "./videos/soap/SoapVideo";
import { soapVideoSchema } from "./videos/soap/schema";
import { calculateSoapVideoMetadata } from "./videos/soap/metadata";
import { QuestionShowcase } from "./templates/question-showcase/QuestionShowcase";
import { calculateQuestionShowcaseMetadata } from "./templates/question-showcase/metadata";
import { questionShowcaseSchema } from "./templates/question-showcase/schema";

export const RemotionRoot: React.FC = () => (
  <>
    <Composition
      id="Slideshow"
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
        shaderColor1: "#211f1a",
        shaderColor2: "#29312c",
        shaderColor3: "#41483f",
        shaderColor4: "#111414",
        motionSpeed: 0.65,
        shaderSpeed: 0.55,
        shaderTransitionSpeed: 1.5,
        shaderTransitionLeadSeconds: 0.65,
        shaderTransitionTrailSeconds: 0.2,
        shaderTransitionEaseSeconds: 0.3,
        shaderDistortion: 0.3,
        shaderSwirl: 0.1,
        shaderDarkness: 0.1,
        fontScale: 1,
        imageScale: 1,
        whipBlur: 24,
      }}
    />
    <Composition
      id="QuestionShowcase"
      component={QuestionShowcase}
      durationInFrames={495}
      fps={30}
      width={1080}
      height={1920}
      schema={questionShowcaseSchema}
      calculateMetadata={calculateQuestionShowcaseMetadata}
      defaultProps={{
        question: "Can faith and doubt exist at the same time?",
        callToAction: "See More Below ↓",
        mediaSrc: "videos/soap/image 114.png",
        backgroundSrc: "",
        musicSrc: "",
        musicSource: "",
        musicVolume: 1,
        durationInSeconds: 16.5,
        mediaScale: 1,
        mediaVolume: 0,
        backgroundDarkness: 0.5,
        backgroundSaturation: 0.18,
        backgroundBrightness: 0.42,
        verseHighlightRects: [],
        studyHighlightRects: [],
        shaderColor1: "#09130f",
        shaderColor2: "#14261d",
        shaderColor3: "#2c4336",
        shaderColor4: "#0b1712",
      }}
    />
  </>
);

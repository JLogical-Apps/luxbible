import type { CalculateMetadataFunction } from "remotion";
import type { QuestionShowcaseProps } from "./schema";

const getSlug = (value: string) =>
  value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "")
    .slice(0, 48) || "question";

export const calculateQuestionShowcaseMetadata: CalculateMetadataFunction<
  QuestionShowcaseProps
> = ({ props }) => ({
  durationInFrames: Math.ceil(props.durationInSeconds * 30),
  defaultOutName: `${getSlug(props.question)}.mp4`,
});

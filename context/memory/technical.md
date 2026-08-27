# Technical Direction

## Status

An initial Flutter app shell exists. It uses the shared `lux` and `style` packages, but the memorization architecture remains exploratory and this is not a final technical specification.

The current app bundle includes only the BSB translation as a single Bible JSON file. Lux Memory loads the full Bible from that file, and chapter access derives from the loaded Bible. Requesting an undeclared translation fails at runtime.

Lux Memory uses the shared interactive passage renderer, passage controller, verse-range selection logic, and chapter selector from `packages/lux`. It supplies a fixed BSB configuration and does not include Lux Bible's annotations, text selection, user-controlled reading layout, study-translation selection, or testament fallback behavior.

## Application Boundary

Lux Memory is expected to be a separate application from Lux Bible. The apps should communicate through explicit user actions and platform-supported links rather than requiring shared installation or shared private storage.

Core memorization should remain available offline and without authentication.

## User Data

The current direction is to keep memorization goals and practice history on the device. A memorization goal may include:

- A passage and translation
- The units being practiced, such as phrases, verses, transitions, references, or a whole passage
- User intent such as active, paused, or saved for later
- A retention preference
- An append-only history of completed practice activities and their results

Memory strength, review readiness, and user-facing growth states should be derived from practice history rather than stored as independent sources of truth. Explicit user choices such as pausing a passage are not derived.

Changing a passage's wording, range, or translation may require a new content revision because previous exact-wording recall does not necessarily apply to the changed passage.

## Scheduling Direction

Users may choose a normal daily practice duration. Lux Memory should build a tentative session from due review, active learning, and optional new material, then revise the remaining plan after every completed activity.

The scheduler should generally:

- Protect previously learned material before introducing additional passages
- Prevent one difficult passage from consuming the entire session
- Continue recent learning when capacity permits
- Stop introducing new material when maintenance exceeds the user's available time
- Estimate activity duration from passage length, activity type, and locally observed practice speed
- Treat the visible garden state as a presentation of deeper memory evidence rather than as the scheduling input itself

The exact memory model and review intervals remain open research and product decisions.

## Lux Bible Integration

Potential integrations include:

- Sending a selected verse or passage from Lux Bible to Lux Memory
- Reviewing and confirming verses imported from a Lux Bible notebook
- Opening a memorized passage in Lux Bible for context or study
- Opening a Lux Memory goal from Lux Bible when the passage is already being learned

Each integration must work gracefully when the other app is not installed.

Bible translation licenses may restrict whether text can be bundled, transferred, stored, practiced, or played as audio in Lux Memory. A translation's availability in Lux Bible does not imply permission to use it in another application.

## Accounts and Privacy

Core functionality should not require an account. A future optional Lux Account may support synchronization, shared plans, and private accountability across Lux products.

An account should not automatically upload notes, reading history, memorization attempts, or other local content. Each synchronized or shared category should have a clear purpose and explicit user control.

Social activity connected to Scripture can reveal sensitive information about religious belief and practice. Data collection, visibility, retention, deletion, child access, and moderation need deliberate legal and product review before account-based features are implemented.

## Telemetry

Lux Memory should not depend on advertising, behavioral tracking, or profiling. Scheduler personalization should operate locally where practical.

Any future aggregate research intended to improve the scheduler should be separate, explicit, and opt-in rather than a condition of using the app.

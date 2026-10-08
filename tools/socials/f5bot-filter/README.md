# F5Bot filter

A Google Apps Script that reads F5Bot alert emails, asks Claude Haiku 5.5 to categorize each Reddit hit, and emails you only the ones worth replying to. Every decision is logged to a Google Sheet with a one-line reason so you can review what it skipped.

Two categories notify:

- `recommend_lux`: the author wants something Lux provides (a Bible app, study tools, commentaries, a reading plan, original-language help) or is unhappy with their current app, so recommending Lux answers them directly.
- `share_soap`: the author is asking how to study or read the Bible. Reply with the SOAP method and bring up Lux if they follow up.

Everything else (passage or doctrine questions, help with other problems, recommendations to others, people promoting their own projects, general discussion) is logged but doesn't notify.

- Runs every 15 minutes inside the Google account that receives the F5Bot emails (`social@jlogical.com` lands in the `jlogical.com` Workspace mailbox).
- Only Reddit hits are classified. Hacker News and Lobsters hits are ignored.
- Hits for `lux bible` skip the classifier and always notify.
- Your own posts and comments (by `u/MacAndCheeseRamen`) are dropped before classification for every keyword, so they never notify or show up in the sheet.
- Haiku returns a `category` and a one-line `reason` as structured JSON, at `low` effort. Whether to notify is derived from the category.
- Cost is roughly $0.05 to $0.10 a month at current F5Bot volume ($0.10 / $0.50 per million input/output tokens).

## Setup

1. Create an Anthropic API key at [platform.claude.com](https://platform.claude.com/settings/keys) and set a monthly spend limit.
2. Optional but recommended: in Gmail, create a filter for `from:alerts@f5bot.com` that skips the inbox and applies a `F5Bot` label. The script doesn't depend on the label; it finds alerts by sender.
3. Signed in as the `jlogical.com` account, open [script.google.com](https://script.google.com), create a project named `F5Bot filter`, and paste [`Code.js`](Code.js) into `Code.gs`.
4. Under **Project Settings > Script properties**, add `ANTHROPIC_API_KEY`.
5. Select `setup` in the function dropdown and click **Run**. Approve the Gmail, Sheets, and external request permissions. This creates the `F5Bot decisions` spreadsheet in your Drive and the 15-minute trigger.

The first run looks back 24 hours, and later runs pick up where the previous one stopped. If a Claude call fails, nothing from that run is logged or marked processed, so the next run retries it. Safety refusals are the exception: they're logged with the category `refused` instead of retried, since retrying returns another refusal.

## Tuning

Use the `Your verdict` column in the sheet to mark mistakes, then:

- Edit `SYSTEM_PROMPT` in `Code.js` if a kind of post is misjudged. Adding the misjudged case to the matching category's description usually works better than rewording the general rule.
- Raise `CLAUDE_EFFORT` to `medium` if the reasons show it misreading posts. That roughly doubles the cost, which is still pennies.

Script properties:

| Property | Purpose |
|---|---|
| `ANTHROPIC_API_KEY` | Required |
| `SHEET_ID` | Set by `setup`; delete it to start a fresh sheet |
| `LAST_PROCESSED_MS` | Set by `run`; delete it to reprocess the last 24 hours |

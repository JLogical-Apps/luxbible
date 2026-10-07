# F5Bot filter

A Google Apps Script that reads F5Bot alert emails, asks [Jev](https://docs.typesafe.ai/introduction) whether each Reddit hit is someone looking for Bible reading or study help, and emails you only the ones worth replying to. Every decision is logged to a Google Sheet so you can review what it skipped.

- Runs every 15 minutes inside the Google account that receives the F5Bot emails (`social@jlogical.com` lands in the `jlogical.com` Workspace mailbox).
- Only Reddit hits are classified. Hacker News and Lobsters hits are ignored.
- Hits for `lux bible` skip the classifier and always notify.
- Your own posts and comments (by `u/MacAndCheeseRamen`) are dropped before classification for every keyword, so they never notify or show up in the sheet.
- Jev answers two questions per hit: `worth_replying` (a 0–1 probability, notify at or above `THRESHOLD`) and `category` (logged so you can see why it decided what it did).
- Cost is about a cent a month at current F5Bot volume (Jev bills $0.042 per million input tokens, output is free).

## Setup

1. Create a TypeSafe API key at [console.typesafe.ai/keys](https://console.typesafe.ai/keys).
2. Optional but recommended: in Gmail, create a filter for `from:alerts@f5bot.com` that skips the inbox and applies a `F5Bot` label. The script doesn't depend on the label; it finds alerts by sender.
3. Signed in as the `jlogical.com` account, open [script.google.com](https://script.google.com), create a project named `F5Bot filter`, and paste [`Code.js`](Code.js) into `Code.gs`.
4. Under **Project Settings > Script properties**, add `TYPESAFE_API_KEY`.
5. Select `setup` in the function dropdown and click **Run**. Approve the Gmail, Sheets, and external request permissions. This creates the `F5Bot decisions` spreadsheet in your Drive and the 15-minute trigger.

The first run looks back 24 hours, and later runs pick up where the previous one stopped. If a Jev call fails, nothing from that run is logged or marked processed, so the next run retries it.

## Tuning

Use the `Your verdict` column in the sheet to mark mistakes, then:

- Change `THRESHOLD` in Script properties (default `0.7`) if the misses cluster just above or below the cutoff.
- Edit the `criteria` in `QUESTIONS` in `Code.js` if a whole kind of post is misjudged. Jev reads instructions literally, so name the exact case ("asking for help with phone habits even if they mention studying the Bible") rather than describing intent loosely.

Script properties:

| Property | Purpose |
|---|---|
| `TYPESAFE_API_KEY` | Required |
| `THRESHOLD` | Notify cutoff for `worth_replying`, default `0.7` |
| `SHEET_ID` | Set by `setup`; delete it to start a fresh sheet |
| `LAST_PROCESSED_MS` | Set by `run`; delete it to reprocess the last 24 hours |

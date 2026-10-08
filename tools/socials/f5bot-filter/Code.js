const CLAUDE_URL = 'https://api.anthropic.com/v1/messages';
const CLAUDE_MODEL = 'claude-haiku-5-5';
const CLAUDE_EFFORT = 'low';
const F5BOT_SENDER = 'alerts@f5bot.com';
const ALWAYS_NOTIFY_KEYWORDS = ['lux bible'];
const MY_REDDIT_USERNAME = 'MacAndCheeseRamen';
const FIRST_RUN_LOOKBACK_MS = 24 * 60 * 60 * 1000;

const SHEET_HEADERS = [
  'Received',
  'Keyword',
  'Subreddit',
  'Type',
  'Title',
  'Excerpt',
  'Notified',
  'Category',
  'Reason',
  'Link',
  'Your verdict',
];

const REPLY_CATEGORIES = ['recommend_lux', 'share_soap'];

const CATEGORIES = [
  ...REPLY_CATEGORIES,
  'passage_question',
  'other_help_request',
  'recommending_to_others',
  'own_project',
  'discussion',
];

const SYSTEM_PROMPT = `You screen Reddit posts and comments for the developer of Lux Bible, a free iPhone, iPad, and Android Bible app with no ads, subscriptions, or account. Lux is for people who want more study depth than a mainstream reading app without the complexity of academic Bible software. It has Greek and Hebrew word data, cross-references, commentaries, translation comparison, reading plans with reminders, highlights, and notes.

The developer replies to two kinds of posts:
- recommend_lux: the author wants something Lux provides, so recommending Lux directly answers them. They're asking for a Bible app, study tools, commentaries, a reading plan, a way to stay consistent with reading, or a way to see the original Greek or Hebrew, or they're unhappy with the Bible app they use.
- share_soap: the author is asking how to study the Bible, how to start reading it, how to get more out of their reading, or how to understand what they read. The developer replies with the SOAP method (Scripture, Observation, Application, Prayer) and mentions Lux only if they follow up.

Everything else gets one of these categories:
- passage_question: asking what a specific passage or word means, or a doctrinal or theological question
- other_help_request: asking for help with a different problem (health, relationships, phone habits, doubts, church conflict), even if they mention studying the Bible
- recommending_to_others: recommending or mentioning Bible resources to someone else
- own_project: announcing, promoting, or sharing stats about their own app, product, or project
- discussion: opinions, testimony, news, debate, or general discussion where the Bible comes up in passing

Each input is one Reddit post, or one comment along with the title of the post it was left on. Excerpts can be cut off. For a comment, judge what the comment's author wants, not the post's author. When a post fits both recommend_lux and share_soap, choose recommend_lux.

In reason, explain the category in one short sentence.`;

const OUTPUT_SCHEMA = {
  type: 'object',
  properties: {
    reason: { type: 'string' },
    category: { type: 'string', enum: CATEGORIES },
  },
  required: ['reason', 'category'],
  additionalProperties: false,
};

function setup() {
  getSheet();
  ScriptApp.getProjectTriggers()
    .filter((trigger) => trigger.getHandlerFunction() === 'run')
    .forEach((trigger) => ScriptApp.deleteTrigger(trigger));
  ScriptApp.newTrigger('run').timeBased().everyMinutes(15).create();
}

function run() {
  const alerts = getNewAlerts();
  if (alerts.length === 0) return;

  // Everything is classified before anything is committed, so a failed Claude call retries the whole batch next run.
  const decisions = alerts.flatMap((message) =>
    parseHits(message.getBody())
      .filter((hit) => hit.author.toLowerCase() !== MY_REDDIT_USERNAME.toLowerCase())
      .map((hit) => ({ ...decide(hit), receivedAt: message.getDate() })),
  );
  logDecisions(decisions);
  notify(decisions.filter((decision) => decision.shouldNotify));
  getProperties().setProperty('LAST_PROCESSED_MS', String(alerts[alerts.length - 1].getDate().getTime()));
}

function getNewAlerts() {
  const since = Number(getProperties().getProperty('LAST_PROCESSED_MS') ?? Date.now() - FIRST_RUN_LOOKBACK_MS);
  return GmailApp.search(`from:${F5BOT_SENDER} after:${Math.floor(since / 1000)}`)
    .flatMap((thread) => thread.getMessages())
    .filter((message) => message.getFrom().includes(F5BOT_SENDER) && message.getDate().getTime() > since)
    .sort((a, b) => a.getDate() - b.getDate());
}

const parseHits = (html) =>
  html
    .split('<h2 class="f5-hit-heading"')
    .slice(1)
    .flatMap((section) => {
      const keyword = toText(section.match(/Keyword: ([\s\S]*?)<\/h2>/)[1]).replace(/^"|"$/g, '');
      return [...section.matchAll(/<p class="f5-hit"[^>]*>([\s\S]*?)<\/p>/g)]
        .map(([, hit]) => parseRedditHit(hit, keyword))
        .filter((hit) => hit != null);
    });

function parseRedditHit(html, keyword) {
  const meta = html.match(/Reddit (Posts|Comments) \(\/r\/([^/]+)\/\):/);
  if (meta == null) return null;

  const [, href, title] = html.match(/<a href="([^"]+)"[^>]*>([\s\S]*?)<\/a>/);
  const excerpt = html.match(/<span class="f5-excerpt"[^>]*>([\s\S]*?)<\/span>/)?.[1] ?? '';
  return {
    keyword,
    kind: meta[1] === 'Posts' ? 'post' : 'comment',
    subreddit: meta[2],
    author: toText(html.match(/>by ([^<]+)<\/span>/)?.[1] ?? ''),
    title: toText(title),
    excerpt: toText(excerpt).replace('Keyword was found in submission title.', '').trim(),
    url: unwrapF5botUrl(decodeEntities(href)),
  };
}

function decide(hit) {
  if (ALWAYS_NOTIFY_KEYWORDS.includes(hit.keyword.toLowerCase())) {
    return { ...hit, shouldNotify: true, category: 'lux_mention', reason: 'Mentions Lux Bible' };
  }
  const { category, reason } = askClaude(toPrompt(hit));
  return { ...hit, shouldNotify: REPLY_CATEGORIES.includes(category), category, reason };
}

const toPrompt = (hit) =>
  JSON.stringify(
    {
      source: hit.kind === 'post' ? 'Reddit post' : 'Reddit comment',
      subreddit: `r/${hit.subreddit}`,
      post_title: hit.title,
      [hit.kind === 'post' ? 'post_text' : 'comment_text']: hit.excerpt,
    },
    null,
    2,
  );

function askClaude(prompt) {
  const apiKey = getProperties().getProperty('ANTHROPIC_API_KEY');
  if (!apiKey) throw new Error('Add ANTHROPIC_API_KEY under Project Settings > Script properties.');

  const response = UrlFetchApp.fetch(CLAUDE_URL, {
    method: 'post',
    contentType: 'application/json',
    headers: { 'x-api-key': apiKey, 'anthropic-version': '2023-06-01' },
    payload: JSON.stringify({
      model: CLAUDE_MODEL,
      max_tokens: 8000,
      system: SYSTEM_PROMPT,
      messages: [{ role: 'user', content: prompt }],
      output_config: { effort: CLAUDE_EFFORT, format: { type: 'json_schema', schema: OUTPUT_SCHEMA } },
    }),
    muteHttpExceptions: true,
  });
  if (response.getResponseCode() !== 200) {
    throw new Error(`Claude returned ${response.getResponseCode()}: ${response.getContentText()}`);
  }

  const message = JSON.parse(response.getContentText());
  // Retrying a refusal returns another refusal, so log it instead of throwing and blocking every later run.
  if (message.stop_reason === 'refusal') {
    return { category: 'refused', reason: `Refused (${message.stop_details?.category})` };
  }
  return JSON.parse(message.content.find((block) => block.type === 'text').text);
}

function logDecisions(decisions) {
  if (decisions.length === 0) return;

  const sheet = getSheet();
  const rows = decisions.map((decision) => [
    decision.receivedAt,
    decision.keyword,
    `r/${decision.subreddit}`,
    decision.kind,
    decision.title,
    decision.excerpt,
    decision.shouldNotify,
    decision.category,
    decision.reason,
    decision.url,
    '',
  ]);
  sheet.getRange(sheet.getLastRow() + 1, 1, rows.length, SHEET_HEADERS.length).setValues(rows);
}

function notify(decisions) {
  if (decisions.length === 0) return;

  const subject =
    decisions.length === 1 ? `Reddit: ${decisions[0].title}` : `Reddit: ${decisions.length} posts worth a look`;
  const sheetUrl = getSheet().getParent().getUrl();
  GmailApp.sendEmail(
    Session.getEffectiveUser().getEmail(),
    subject,
    decisions.map((decision) => `${decision.title}\n${decision.url}`).join('\n\n'),
    {
      name: 'F5Bot filter',
      htmlBody: `${decisions.map(toEmailHtml).join('<hr>')}<p><a href="${sheetUrl}">All decisions</a></p>`,
    },
  );
}

const toEmailHtml = (decision) => `
  <p>
    <a href="${decision.url}"><b>${escapeHtml(decision.title)}</b></a><br>
    <small>r/${decision.subreddit} · ${decision.kind} · "${escapeHtml(decision.keyword)}" · ${decision.category}</small><br>
    <i>${escapeHtml(decision.reason)}</i>
  </p>
  <p>${escapeHtml(decision.excerpt)}</p>`;

function getSheet() {
  const properties = getProperties();
  const sheetId = properties.getProperty('SHEET_ID');
  if (sheetId) return SpreadsheetApp.openById(sheetId).getSheets()[0];

  const spreadsheet = SpreadsheetApp.create('F5Bot decisions');
  const sheet = spreadsheet.getSheets()[0];
  sheet.appendRow(SHEET_HEADERS);
  sheet.setFrozenRows(1);
  properties.setProperty('SHEET_ID', spreadsheet.getId());
  return sheet;
}

const getProperties = () => PropertiesService.getScriptProperties();

const unwrapF5botUrl = (url) => {
  const target = url.match(/^https:\/\/f5bot\.com\/url\?u=([^&]+)/)?.[1];
  return target == null ? url : decodeURIComponent(target);
};

const toText = (html) =>
  decodeEntities(html.replace(/<br\s*\/?>/gi, ' ').replace(/<[^>]+>/g, ''))
    .replace(/​/g, '')
    .replace(/\s+/g, ' ')
    .trim();

const NAMED_ENTITIES = { amp: '&', quot: '"', apos: "'", lt: '<', gt: '>', nbsp: ' ', copy: '©' };

const decodeEntities = (text) =>
  text.replace(/&(#x[0-9a-f]+|#\d+|[a-z]+);/gi, (entity, name) =>
    name.startsWith('#x') || name.startsWith('#X')
      ? String.fromCodePoint(parseInt(name.slice(2), 16))
      : name.startsWith('#')
        ? String.fromCodePoint(Number(name.slice(1)))
        : (NAMED_ENTITIES[name.toLowerCase()] ?? entity),
  );

const escapeHtml = (text) =>
  text.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');

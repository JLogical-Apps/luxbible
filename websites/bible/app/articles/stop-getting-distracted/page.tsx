import ArticleImage from '@/components/layout/ArticleImage';
import ArticlePage from '@/components/layout/ArticlePage';
import type { ArticleTableOfContentsItem } from '@/components/layout/ArticleTableOfContents';
import { focusArticle, getArticleMetadata } from '@/lib/articles';

export const metadata = getArticleMetadata(focusArticle);

const articleMediaPath = `/media/articles/${focusArticle.slug}`;

const tableOfContents: ArticleTableOfContentsItem[] = [
  { id: 'short-version', label: 'The short version' },
  { id: 'silence-notifications', label: 'Silence notifications' },
  { id: 'silence-iphone', label: 'iPhone', level: 3 },
  { id: 'silence-android', label: 'Android', level: 3 },
  { id: 'limit-apps', label: 'Limit distracting apps' },
  { id: 'limit-iphone', label: 'iPhone', level: 3 },
  { id: 'limit-android', label: 'Android', level: 3 },
  { id: 'read-offline', label: 'Read offline' },
  { id: 'easy-to-open', label: 'Make Scripture easy to open' },
  { id: 'plan-ahead', label: 'Know what you will read' },
  { id: 'when-distracted', label: 'When you get distracted' },
];

export default function FocusArticlePage() {
  return (
    <ArticlePage article={focusArticle} tableOfContents={tableOfContents}>
      <p>
        You open your Bible app with good intentions. A notification slides
        down, you tap it, and twenty minutes later you are scrolling somewhere
        you never meant to go. If that sounds familiar, you are not alone.
      </p>

      <p>
        A phone can be a great place to read Scripture. It puts commentaries,
        cross-references, original-language tools, and search a tap away in a
        way a printed Bible cannot. But the same device is designed to pull your
        attention somewhere else. The good news is that iPhone and Android
        already include the tools you need to tip the balance back toward
        Scripture. This guide walks through the settings I would recommend, with
        steps for both.
      </p>

      <h2 id="short-version">The short version</h2>

      <ol>
        <li>
          <strong>Silence notifications automatically</strong> whenever you open
          your Bible app.
        </li>
        <li>
          <strong>Limit the apps that pull you away</strong>, especially during
          the time you set aside to read.
        </li>
        <li>
          <strong>Make your Bible app the easiest thing to open</strong> when
          you pick up your phone.
        </li>
      </ol>

      <p>
        Each step takes a few minutes to set up and works on its own after that.
      </p>

      <h2 id="silence-notifications">Silence notifications while you read</h2>

      <p>
        Most distractions start with a notification. One text is enough
        to pull you out of a passage, and it rarely ends with that one message.
        The best fix is one you never have to remember: have Do Not Disturb turn
        on by itself when you open your Bible app.
      </p>

      <h3 id="silence-iphone">iPhone</h3>

      <p>
        iPhone can turn on a Focus whenever you open a specific app and turn it
        off again when you leave.
      </p>

      <ol>
        <li>
          Open <strong>Settings &gt; Focus</strong> and choose{' '}
          <strong>Do Not Disturb</strong>. You can also tap <strong>+</strong>{' '}
          to create a custom Focus named something like “Bible Reading.”
        </li>
        <li>
          Under <strong>Set a Schedule</strong>, tap{' '}
          <strong>Add Schedule</strong>, then <strong>App</strong>.
        </li>
        <li>Choose your Bible app.</li>
      </ol>

      <ArticleImage
        sources={[
          `${articleMediaPath}/focus_list.png`,
          `${articleMediaPath}/focus_schedule.png`,
        ]}
        alt="The iPhone Focus list and a Do Not Disturb schedule that turns on while using Lux Bible"
        caption="Do Not Disturb set to turn on while using Lux Bible."
      />

      <p>
        Do Not Disturb now turns on as soon as you open your Bible app and turns
        off when you switch to another app. Calls from the people you allow,
        such as your favorites, still come through.
      </p>

      <p>
        You can get the same result with two automations in the Shortcuts app:
      </p>

      <ol>
        <li>
          Open <strong>Shortcuts</strong>, tap <strong>Automation</strong>, then
          tap <strong>+</strong>.
        </li>
        <li>
          Choose <strong>App</strong>, select your Bible app, check{' '}
          <strong>Is Opened</strong>, and choose{' '}
          <strong>Run Immediately</strong>.
        </li>
        <li>
          Add the <strong>Set Focus</strong> action and set it to turn Do Not
          Disturb on until turned off.
        </li>
        <li>
          Create a second automation the same way, but check{' '}
          <strong>Is Closed</strong> and set it to turn Do Not Disturb off.
        </li>
      </ol>

      <ArticleImage
        sources={[
          `${articleMediaPath}/shortcut.png`,
          `${articleMediaPath}/shortcut_closed.png`,
        ]}
        alt="Shortcuts automations that turn Do Not Disturb on when Lux Bible opens and off when it closes"
        caption="Do Not Disturb turns on when Lux Bible opens and off when it closes."
      />

      <p>
        If you would rather keep Do Not Disturb on when you briefly step out of
        your Bible app, such as to write in a journal app, skip the second
        automation. Just remember to turn Do Not Disturb off in Control Center
        when you finish reading.
      </p>

      <h3 id="silence-android">Android</h3>

      <p>The options on Android depend on your phone.</p>

      <ul>
        <li>
          <strong>Samsung Galaxy:</strong> Modes and Routines can turn on Do Not
          Disturb when an app opens. Go to{' '}
          <strong>Settings &gt; Modes and Routines &gt; Routines</strong> and
          tap <strong>+</strong>. Under <strong>If</strong>, add{' '}
          <strong>App opened</strong> and choose your Bible app. Under{' '}
          <strong>Then</strong>, add <strong>Do not disturb</strong> and set it
          to on. When you leave the app, the routine ends and your previous
          settings return.
        </li>
        <li>
          <strong>Pixel and other phones:</strong> There is no built-in way to
          start Do Not Disturb when a specific app opens. Instead, create a mode
          in <strong>Settings &gt; Modes</strong> named something like “Bible
          Reading” and choose which people and apps can still reach you. Then
          schedule it for the time you usually read, or turn it on from Quick
          Settings before you open your Bible. On older versions of Android, the
          same options are under Do Not Disturb.
        </li>
      </ul>

      <ArticleImage
        sources={[`${articleMediaPath}/android_mode.png`]}
        alt="A Bible Reading mode on a Pixel scheduled from 7:30 AM to 8:00 AM every day"
        caption="A Bible Reading mode on a Pixel that turns on every morning from 7:30 to 8:00."
      />

      <h2 id="limit-apps">Limit the apps that pull you away</h2>

      <p>
        Sometimes no notification is needed. Habit alone can send your thumb to
        another app halfway through a chapter. Both iPhone and Android let you
        put limits on the apps you reach for most.
      </p>

      <h3 id="limit-iphone">iPhone</h3>

      <p>
        Open <strong>Settings &gt; Screen Time</strong>. Two features are
        especially helpful.
      </p>

      <p>
        <strong>App Limits</strong> set a daily time limit for apps or whole
        categories. Tap <strong>App Limits &gt; Add Limit</strong> and choose
        categories such as Social, Games, and Entertainment. Once you reach the
        limit, those apps are blocked for the rest of the day.
      </p>

      <ArticleImage
        sources={[`${articleMediaPath}/app_limits.png`]}
        alt="An iPhone App Limit of one hour per day for Games, Social, and Entertainment"
        caption="A one-hour daily limit for games, social, and entertainment apps."
      />

      <p>
        <strong>Downtime</strong> schedules a window when only the apps you
        choose are available. If you read first thing in the morning, set
        Downtime to end after your usual reading time so nothing else competes
        for your attention. Add your Bible app to{' '}
        <strong>Always Allowed</strong> in Screen Time so it stays available.
      </p>

      <ArticleImage
        sources={[`${articleMediaPath}/downtime.png`]}
        alt="iPhone Downtime scheduled every day from 10:00 PM to 7:00 AM"
        caption="Downtime from 10 PM to 7 AM. Only phone calls and allowed apps work during that window."
      />

      <p>
        These limits are easy to bypass, since Screen Time lets you ignore a
        limit with a tap. To make them stick, turn on{' '}
        <strong>Lock Screen Time Settings</strong> and ask a friend or family
        member to choose the passcode for you.
      </p>

      <h3 id="limit-android">Android</h3>

      <p>
        Open{' '}
        <strong>Settings &gt; Digital Wellbeing &amp; parental controls</strong>
        . You will find two helpful tools there.
      </p>

      <p>
        <strong>App timers</strong> set a daily limit for any app. When the
        timer runs out, the app is paused for the rest of the day.
      </p>

      <p>
        <strong>Focus</strong> pauses a group of distracting apps all at once.
        Turn it on before you read or schedule it for your usual reading time.
        Paused apps don&apos;t send notifications, and opening one reminds you
        that it is paused. On Samsung phones, the modes in Modes and Routines
        serve a similar purpose.
      </p>

      <ArticleImage
        sources={[
          `${articleMediaPath}/app_timers.png`,
          `${articleMediaPath}/focus_pixel.png`,
        ]}
        alt="30-minute app timers on a Pixel next to a Focus schedule from 9:00 PM to 8:00 AM on weekdays that pauses social and video apps"
        caption="30-minute app timers next to a Focus schedule that pauses social and video apps overnight on weekdays."
      />

      <h2 id="read-offline">Read offline</h2>

      <p>
        The surest way to stop interruptions is to disconnect entirely. Airplane
        mode blocks messages, notifications, and the temptation to look
        something up online. It also blocks calls, so it works best when you
        don&apos;t need to be reachable.
      </p>

      <p>
        Before you try it, make sure your Bible app works without a connection.
        Many apps stream their translations and study tools, so they stop
        working the moment you go offline. If your app lets you download
        translations, do that ahead of time.
      </p>

      <p>
        Being able to study anywhere was one of the reasons I built Lux to work
        offline. Its included translations, such as the BSB, CSB, and KJV, work
        in airplane mode along with its commentaries, cross-references,
        interlinear, lexicons, and dictionaries. Online translations and audio
        still need a connection.
      </p>

      <h2 id="easy-to-open">Make Scripture the easy thing to open</h2>

      <p>
        Habits follow the path of least resistance. If your thumb goes straight
        to social media every time you unlock your phone, give it something
        better to find.
      </p>

      <ul>
        <li>
          <strong>Swap places.</strong> Move your Bible app to the spot your
          most distracting app used to occupy, such as the dock or the first
          position on your home screen. Move the distracting app into a folder
          on a later page.
        </li>
        <li>
          <strong>Add a verse of the day widget.</strong> Many Bible apps,
          including Lux, offer one, so the first thing you see when you unlock
          your phone is Scripture.
        </li>
        <li>
          <strong>Set a daily reminder.</strong> A reminder from your Bible app
          is a notification that pulls you toward Scripture instead of away from
          it. In Lux, you can schedule a Verse of the Day or Bible plan reminder
          for any time of day, so pick the time you want to read. When it
          arrives, commit to leaving it on your screen until you have read.
          Tapping it takes you straight to the passage.
        </li>
      </ul>

      <ArticleImage
        sources={[
          `${articleMediaPath}/widget.png`,
          `${articleMediaPath}/reminders.png`,
        ]}
        alt="The Lux Bible Verse of the Day widget on an iPhone home screen and the Lux Push Notifications page"
        caption="The Verse of the Day widget next to Verse of the Day and Bible plan reminder times in Lux."
      />

      <h2 id="plan-ahead">Know what you will read before you open</h2>

      <p>
        Distraction often creeps in right after you open your Bible, while you
        wonder where to start. A few seconds of indecision is enough to send you
        to another app. Deciding ahead of time removes that moment.
      </p>

      <p>
        A reading plan works well for this. It tells you exactly which passage
        is next, and checking off each day gives you a reason to come back
        tomorrow. If you prefer to choose for yourself, pick tomorrow&apos;s
        passage when you finish today&apos;s.
      </p>

      <ArticleImage
        sources={[`${articleMediaPath}/bible_plan.png`]}
        alt="A Bible plan in Lux Bible showing Day 2 with Genesis 3 through 5 and Matthew 2"
        caption="A Bible plan in Lux, with each day's passages ready to check off."
      />

      <p>
        A regular time and place help too. Reading at the same point in your
        day, such as with your morning coffee or before bed, turns it into a
        habit rather than a decision you make each time. Jesus Himself made room
        to be alone with the Father.
      </p>

      <blockquote>
        <p>
          Early in the morning, while it was still dark, Jesus got up and went
          out to a solitary place to pray.
        </p>
        <footer>Mark 1:35, BSB</footer>
      </blockquote>

      <h2 id="when-distracted">When you get distracted anyway</h2>

      <p>
        No setting will make you perfectly focused. Now and then you will still
        catch yourself halfway through another app. When it happens, close it
        and go back to where you left off. You don&apos;t need to start over or
        feel guilty. The goal is time with God, not a perfect record.
      </p>

      <p>
        The psalmist knew his eyes could wander too, and he asked God to turn
        them back toward His word. It is a good prayer to pray before you start
        reading.
      </p>

      <blockquote>
        <p>
          Turn my eyes away from worthless things; revive me with Your word.
        </p>
        <footer>Psalm 119:37, BSB</footer>
      </blockquote>

      <p>
        Set up one or two of these today, and see how much more of your reading
        time actually goes to reading.
      </p>
    </ArticlePage>
  );
}

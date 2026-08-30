import ArticleImage from '@/components/layout/ArticleImage';
import ArticlePage from '@/components/layout/ArticlePage';
import type { ArticleTableOfContentsItem } from '@/components/layout/ArticleTableOfContents';
import { getArticleMetadata, soapArticle } from '@/lib/articles';

export const metadata = getArticleMetadata(soapArticle);

const articleMediaPath = '/media/articles/how-to-study-the-bible-with-soap';

const tableOfContents: ArticleTableOfContentsItem[] = [
  { id: 'bible-study-method', label: 'What is a Bible study method?' },
  { id: 'scripture', label: 'Scripture' },
  { id: 'observation', label: 'Observation' },
  { id: 'study-tools', label: 'Study tools', level: 3 },
  { id: 'where-to-find-tools', label: 'Where to find tools', level: 3 },
  { id: 'study-romans-12-2', label: 'Study Romans 12:2', level: 3 },
  { id: 'summarize', label: 'Summarize', level: 3 },
  { id: 'application', label: 'Application' },
  { id: 'prayer', label: 'Prayer' },
  { id: 'conclusion', label: 'Conclusion' },
];

export default function SoapArticlePage() {
  return (
    <ArticlePage article={soapArticle} tableOfContents={tableOfContents}>
      <p>
        Many of us have opened the Bible with good intentions, read a passage,
        and realized a few minutes later that we skimmed right over it. When we
        do not understand what is happening, it is easy to keep moving without
        grasping what the passage says or why it matters.
      </p>

      <p>
        The Bible is meant to be read, but careful study helps us slow down and
        discover deeper truths about God. It also helps us respond faithfully
        instead of leaving what we read on the page. This guide explains a
        simple Bible study method that anyone can use, whether you are a new
        believer or have studied Scripture for years.
      </p>

      <h2 id="bible-study-method">What is a Bible study method?</h2>

      <p>
        A Bible study method is a set of principles, tools, and steps that guide
        us as we examine Scripture. There are many useful methods, each with a
        slightly different emphasis. In this article, we will use SOAP because
        it is easy to remember and effective at helping us understand Scripture
        and apply it to our lives.
      </p>

      <p>
        SOAP stands for <strong>Scripture</strong>, <strong>Observation</strong>
        , <strong>Application</strong>, and <strong>Prayer</strong>. As we work
        through each step, we will use Romans 12:2 as an example. Let&apos;s
        dive in.
      </p>

      <h2 id="scripture">Scripture</h2>

      <ArticleImage
        sources={[`${articleMediaPath}/romans_12_2.png`]}
        alt="Romans 12:2 open in Lux Bible"
        caption="Romans 12:2 open in Lux."
      />

      <p>
        Choose a passage and read it several times. If it helps, write it out by
        hand or say it aloud. Both practices force you to slow down and process
        the wording more intentionally. Your passage might be one verse or a few
        paragraphs, depending on the time you have.
      </p>

      <p>
        Do not isolate the passage from its context. Once you have spent time
        with the passage itself, read the surrounding paragraph and chapter.
        Learn where that section fits within the book so you can follow the
        author&apos;s train of thought. Context is especially important when a
        passage begins with a word such as “therefore” or “for,” since those
        words directly connect it to what came before.
      </p>

      <p>
        Romans 12:2 belongs with Romans 12:1, which begins, “Therefore I urge
        you, brothers, on account of God&apos;s mercy.” The “therefore” points
        back to Romans 1 through 11, where Paul explains the depth of God&apos;s
        mercy in saving undeserving sinners. Romans 11 closes with praise for
        God&apos;s wisdom and mercy. Romans 12 then turns toward the life that
        should follow from receiving that mercy. Reading Romans 12:1-2 together
        keeps verse 2 connected to that larger movement.
      </p>

      <h2 id="observation">Observation</h2>

      <p>
        As you meditate on a passage, questions will probably arise. What does
        this word mean? What is the passage saying theologically and
        practically? Where do the same themes or principles appear elsewhere in
        the Bible? Observation is where we do our best to answer those questions
        while keeping the passage itself at the center.
      </p>

      <h3 id="study-tools">Types of study tools</h3>

      <p>Different tools help answer different kinds of questions:</p>

      <ul>
        <li>
          <strong>Bible dictionaries</strong> define biblical words, people,
          places, and ideas.
        </li>
        <li>
          <strong>Concordances</strong> show where a word appears throughout the
          Bible.
        </li>
        <li>
          <strong>Translation comparisons</strong> place the wording of several
          Bible translations side by side.
        </li>
        <li>
          <strong>Cross-references</strong> point to passages with related
          language, themes, events, or principles.
        </li>
        <li>
          <strong>Commentaries</strong> contain theological or practical
          explanations written by Bible scholars and teachers.
        </li>
        <li>
          <strong>
            Interlinears, lexicons, and Greek or Hebrew concordances
          </strong>{' '}
          connect a translated verse to its original-language words, explain
          those words, and show where else they occur in Scripture.
        </li>
      </ul>

      <p>
        No tool should replace reading the passage carefully. Dictionaries and
        lexicons list possible meanings, but the sentence and its context help
        determine which meaning fits. Commentaries can also disagree, so read
        them as informed guides rather than treating one writer as the final
        word.
      </p>

      <h3 id="where-to-find-tools">Where to find study tools</h3>

      <p>
        A well-rounded study often draws from several of these tools. They can
        be purchased as books or found across different websites, but switching
        between a stack of books and several browser tabs can make a focused
        study harder. Websites also require an internet connection, and ads are
        designed to pull your attention away from what you are reading.
      </p>

      <p>
        That frustration was one of the biggest reasons I built Lux. I wanted
        the study tools I regularly use to be available where I was already
        reading. Lux includes translation comparison, interlinear and lexical
        data, cross-references, commentaries, dictionaries, and concordance
        results for free, without ads, and with its core study resources
        available offline.
      </p>

      <p>
        This article shows these tools in Lux, but the SOAP method does not
        depend on Lux. Use resources you already own or another study site that
        works well for you. Helpful online options include:
      </p>

      <ul>
        <li>
          <a href="https://biblehub.com/">Bible Hub</a>, an ad-supported site
          with parallel translations, commentaries, cross-references,
          interlinears, lexicons, dictionaries, and concordances.
        </li>
        <li>
          <a href="https://www.biblegateway.com/">Bible Gateway</a>, an
          ad-supported site with many Bible translations, parallel reading,
          search, commentaries, dictionaries, and other reference works. Some
          resources require Bible Gateway Plus.
        </li>
        <li>
          <a href="https://www.blueletterbible.org/">Blue Letter Bible</a>, a
          free site with interlinears, lexicons, concordance
          results, translation tools, dictionaries, cross-references, and
          commentaries.
        </li>
        <li>
          <a href="https://www.stepbible.org/">STEP Bible</a>, a free, ad-free
          study site with translation comparison, original-language vocabulary,
          interlinear information, and related-word searches.
        </li>
        <li>
          <a href="https://www.bible.com/">YouVersion</a>, a free, ad-free site
          and app with many Bible translations, comparison, search, audio, and
          reading plans. Its focus is Bible reading rather than a complete set
          of original-language and commentary tools.
        </li>
      </ul>

      <h3 id="study-romans-12-2">Study Romans 12:2</h3>

      <p>
        Let&apos;s use a few study tools on Romans 12:2, focusing on the phrase
        “by the renewing of your mind.” This will be a surface-level overview.
        In a longer study, you could also examine words such as “conformed,”
        “world,” and “transformed.”
      </p>

      <h4>Look up “renewing”</h4>

      <ArticleImage
        sources={[
          `${articleMediaPath}/renewing_interlinear.png`,
          `${articleMediaPath}/renewing_lexicon.png`,
        ]}
        alt="Renewing selected in the Romans 12:2 interlinear and the G342 lexicon entry"
        caption="“Renewing” selected in the Romans 12:2 interlinear next to the G342 lexicon entry."
      />

      <p>
        The word translated “renewing” is connected to Strong&apos;s G342. Its
        biblical usage includes “a renewal, renovation, complete change for the
        better.” This does not sound like a minor adjustment. It conveys a
        thorough change, almost like being made new.
      </p>

      <h4>Look up “mind”</h4>

      <ArticleImage
        sources={[
          `${articleMediaPath}/mind_interlinear.png`,
          `${articleMediaPath}/mind_lexicon.png`,
        ]}
        alt="Mind selected in the Romans 12:2 interlinear and the G3563 lexicon entry"
        caption="“Mind” selected in the Romans 12:2 interlinear next to the G3563 lexicon entry."
      />

      <p>
        The word translated “mind” is connected to Strong&apos;s G3563. Its
        biblical usage includes “a particular mode of thinking and judging,”
        including a person&apos;s “thoughts, feelings, purposes, desires.” The
        mind here is not merely the thinking part of our brain. The word reaches
        into how we judge, what we feel, what we want, and what we live for.
      </p>

      <h4>Read a commentary</h4>

      <ArticleImage
        sources={[`${articleMediaPath}/matthew_henry.png`]}
        alt="Matthew Henry's commentary on Romans 12:2 in Lux Bible"
        caption="Matthew Henry's commentary on Romans 12:2."
      />

      <p>
        Matthew Henry writes, “Conversion and sanctification are the renewing of
        the mind; a change, not of the substance, but of the qualities of the
        soul.” In other words, renewing our minds does not mean receiving a
        physically different mind. It means that the qualities and direction of
        our inner life are changed.
      </p>

      <h4>Follow a cross-reference</h4>

      <ArticleImage
        sources={[
          `${articleMediaPath}/cross_references.png`,
          `${articleMediaPath}/eph_4_22-24.png`,
        ]}
        alt="Romans 12:2 cross-references and an expanded Ephesians 4:22-24 preview in Lux Bible"
        caption="The cross-references for Romans 12:2 next to Ephesians 4:22-24."
      />

      <p>
        Ephesians 4:22-24 tells believers to “put off your former way of life,
        your old self,” to “be renewed in the spirit of your minds,” and to “put
        on the new self, created to be like God in true righteousness and
        holiness.” This cross-reference gives us a fuller picture of renewal.
        Our thoughts, attitudes, and inner direction are to be transformed from
        our former way of life toward a new life that reflects God.
      </p>

      <p>
        There is so much we can glean from one short phrase. Imagine how much
        more we might notice by carefully studying the rest of this verse.
      </p>

      <h3 id="summarize">Summarize what you observed</h3>

      <p>
        Once you have read the surrounding context, meditated on the passage,
        and studied it closely, summarize the passage and its train of thought
        in your own words. Writing the summary in a journal or notes app helps
        you articulate what you learned and gives you something to revisit.
      </p>

      <ArticleImage
        sources={[`${articleMediaPath}/summary_annotation.png`]}
        alt="A summary note attached to a selected phrase in Romans 12:2"
        caption="Noting the summary of “by the renewing of your mind”."
      />

      <p>Here is one possible summary of the phrase we studied:</p>

      <blockquote>
        <p>
          God&apos;s mercies are so impactful that they should transform our
          thoughts, feelings, purposes, and desires from the former ways of the
          world toward a new life created to be like God.
        </p>
      </blockquote>

      <h2 id="application">Application</h2>

      <p>
        After reading and studying a passage, we should know more about God and
        His Word. But learning is not the end of a good Bible study.
      </p>

      <blockquote>
        <p>
          Be doers of the word, and not hearers only. Otherwise, you are
          deceiving yourselves.
        </p>
        <footer>James 1:22, BSB</footer>
      </blockquote>

      <p>
        Application can take many forms. A passage might lead us to praise God,
        change how we think about something, treat another person differently,
        or get up and do or say something. A helpful application is concrete and
        measurable rather than vague or generic.
      </p>

      <p>
        For Romans 12:2, “I should renew my mind” is true but difficult to act
        on. A more specific application might be: “I will identify one way I
        still think like the world, repent of it, and discuss it with a trusted
        spiritual leader who can help me replace that pattern with truth from
        Scripture.” Applications will differ from person to person, so choose a
        response that is faithful to the passage and relevant to your life.
      </p>

      <p>Here are a few more practical examples from Romans 12:2:</p>

      <ul>
        <li>
          For the next seven mornings, I will read Romans 12:1-2 before checking
          social media and ask which source is shaping my thoughts.
        </li>
        <li>
          I will write down one recurring belief about success, appearance, or
          status that reflects the world&apos;s values, then find and memorize a
          passage that corrects it.
        </li>
        <li>
          Before making the decision I am currently facing, I will ask whether
          each option reflects what God calls good, pleasing, and faithful.
        </li>
        <li>
          This week I will ask a mature believer to point out one pattern in my
          attitudes or behavior that may need to change, and I will listen
          without defending myself.
        </li>
      </ul>

      <p>
        Record your application in a journal or notes app, then revisit it in a
        week and honestly check your progress.
      </p>

      <ArticleImage
        sources={[
          `${articleMediaPath}/application_annotation.png`,
          `${articleMediaPath}/all_applications.png`,
        ]}
        alt="An application note and a list of previous application notes in Lux Bible"
        caption="Noting an application next to a list of all other Application highlights."
      />

      <h2 id="prayer">Prayer</h2>

      <p>
        End your study by praying over what you read. You can pray phrases from
        the passage, ask God to help you retain its truth, and ask the Holy
        Spirit to empower you to apply it faithfully. Your prayer does not need
        to be long or polished. It should be an honest response to God.
      </p>

      <p>A prayer from this study might sound like this:</p>

      <blockquote>
        <p>
          God, thank You for the mercy You have shown me. Reveal the ways I am
          still being shaped by the world, and forgive me for accepting those
          patterns. Renew my thoughts, feelings, purposes, and desires. Help me
          put off my old way of life and become more like You. Give me wisdom to
          recognize what is good, pleasing, and according to Your will, and give
          me strength through Your Spirit to live it out. Amen.
        </p>
      </blockquote>

      <h2 id="conclusion">Keep studying</h2>

      <p>
        Studying the Bible takes time, but it is deeply enriching. SOAP gives us
        a simple pattern we can remember: read the Scripture, observe it
        carefully, choose a faithful application, and respond in prayer.
      </p>

      <p>
        Hopefully, this method encourages you to slow down, dig deeper into the
        Word, and let its truth shape your life through the power that comes
        from God.
      </p>
    </ArticlePage>
  );
}

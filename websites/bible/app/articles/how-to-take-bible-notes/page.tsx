import ArticleImage from '@/components/layout/ArticleImage';
import ArticlePage from '@/components/layout/ArticlePage';
import type { ArticleTableOfContentsItem } from '@/components/layout/ArticleTableOfContents';
import { getArticleMetadata, noteTakingArticle } from '@/lib/articles';

export const metadata = getArticleMetadata(noteTakingArticle);

const articleMediaPath =
  '/media/articles/bible-word-study-without-greek-or-hebrew';

const tableOfContents: ArticleTableOfContentsItem[] = [
  { id: 'why-take-notes', label: 'Why take Bible notes?' },
  { id: 'where-to-take-notes', label: 'Where to take notes' },
  { id: 'read', label: 'Read' },
  { id: 'highlight-themes', label: 'Highlight key themes', level: 3 },
  { id: 'parallel-passages', label: 'Note parallel passages', level: 3 },
  { id: 'reflect', label: 'Reflect' },
  { id: 'summarize', label: 'Summarize readings', level: 3 },
  { id: 'applications', label: 'Track applications', level: 3 },
  { id: 'study', label: 'Study' },
  { id: 'word-studies', label: 'Record word studies', level: 3 },
  { id: 'analysis', label: 'Capture your analysis', level: 3 },
  { id: 'conclusion', label: 'Build your system' },
];

export default function NoteTakingArticlePage() {
  return (
    <ArticlePage article={noteTakingArticle} tableOfContents={tableOfContents}>
      <p>
        A good Bible note-taking system can transform your daily reading. It
        helps you slow down, recognize what matters, retain what you learn, and
        return to insights and applications long after you first wrote them. A
        system is more than a collection of highlights. It is a simple plan for
        what you record, how you organize it, and when you revisit it.
      </p>

      <h2 id="why-take-notes">Start with why you read</h2>

      <p>
        The best system begins with a simple question:{' '}
        <strong>Why are you reading the Bible?</strong> Someone reading several
        chapters a day to finish the Bible in a year needs quick notes that
        preserve the broad story. Someone spending a morning on a few verses
        needs room for commentaries, cross-references, original-language work,
        and a careful conclusion. Your notes should support your purpose, not
        become another task to complete.
      </p>

      <p>
        Your note-taking system should amplify that goal. Notes for broad
        reading should help you preserve themes and connections without
        continually interrupting your progress. Notes for reflection should help
        you retain and apply what you read. Notes for deeper study should
        preserve the findings and conclusions you may want to revisit. A system
        becomes distracting when it asks you to record more than your purpose
        requires.
      </p>

      <p>
        We will examine suggested note-taking systems for three common goals:{' '}
        <strong>Read</strong> for breadth and the big picture,{' '}
        <strong>Reflect</strong> for personal understanding and application, and{' '}
        <strong>Study</strong> for detailed analysis. These goals can overlap.
        The point is to recognize which one is leading a particular reading
        session, then use a system that helps you pursue it.
      </p>

      <h2 id="where-to-take-notes">Where should you take notes?</h2>

      <p>
        Before we look at those goals and their suggested systems, we need to
        decide where the notes will live. The medium you choose affects how you
        capture observations, organize them, and find them again later.
      </p>

      <p>
        Paper and digital notes can both work well. The right choice depends on
        how you read, what helps you remember, and how you want to find your
        notes later.
      </p>

      <h3>Writing in a Bible or notebook</h3>

      <p>
        Highlighting a physical Bible can be deeply satisfying. After a year of
        reading, its pages become a visible record of the passages you have
        spent time with. Margin notes also keep an observation beside the text
        that prompted it, while a wide-margin Bible or separate notebook gives
        longer thoughts more room.
      </p>

      <p>
        Writing by hand also forces you to slow down and can make an observation
        easier to remember. Paper gives you complete freedom to choose colors,
        underlines, boxes, circles, symbols, and layouts. If your margins become
        crowded, use the Bible for short references and highlights while keeping
        longer notes in a separate notebook.
      </p>

      <p>
        The limitations appear when you want to find something again. Collecting
        every note about salvation or the attributes of God may require
        searching page by page. You also need your Bible, notebook, and supplies
        nearby. An insight from a sermon or conversation can be harder to
        capture when those materials are at home.
      </p>

      <h3>Taking notes digitally</h3>

      <p>
        Digital notes give you more writing space and make your work easier to
        search and organize. You can keep a note beside the passage that
        prompted it while also viewing related notes together on a separate
        page. Since your phone is usually nearby, you can capture an insight
        during a sermon, conversation, or commute before you forget it.
      </p>

      <p>
        The tradeoff is that an app determines which annotation tools are
        available. Many Bible apps only attach a highlight or note to a whole
        verse. Lux lets you annotate verses or individual phrases, name more
        than 20 highlight styles, and organize annotations into notebooks.
        Phrase-level notes are especially useful when an observation applies to
        one expression or when you are recording a word study. You can filter
        annotations by notebook or style, and hide notebooks when you want a
        less cluttered reading view. Lux is free, without ads, and its core
        reading and note-taking features work offline.
      </p>

      <ArticleImage
        sources={[
          `${articleMediaPath}/phrase_annotation.png`,
          `${articleMediaPath}/key_insight_annotations.png`,
        ]}
        alt="A Key Insight note on Romans 12:2 and annotations filtered by the Key Insight style in Lux"
        caption="Adding a Key Insight to a phrase in Romans 12:2 next to other annotations marked with the same style."
      />

      <p>
        You do not have to choose only paper or only digital notes. A physical
        Bible can remain your primary reading space while an app stores longer
        notes you want to search later. Choose the combination you are most
        likely to use consistently.
      </p>

      <p>
        With a place to store your notes in mind, we can now look at each
        reading goal and its suggested note-taking system. Start with the goal
        that most closely describes what you want from Scripture in your current
        season.
      </p>

      <h2 id="read">Read: Remember the big picture</h2>

      <p>
        You might be reading the Bible for the first time, or reading through it
        again to revisit its stories and themes. In either case, your goal is
        breadth: to learn who God is, recognize key principles and applications,
        and see how the parts of Scripture connect. Since you may read several
        chapters at a time, your notes should be light enough that they help you
        notice the big picture without stopping your reading every few
        sentences.
      </p>

      <h3 id="highlight-themes">Highlight key themes</h3>

      <p>
        Choose a small set of themes that matter to your reading. Joy and
        Delight, Attributes of God, Salvation, Church, and Applications are
        possible starting points. Avoid creating a category for everything you
        notice. Four or five broad themes are easier to remember and use
        consistently.
      </p>

      <ol>
        <li>
          Give each theme a distinct color or highlight style. If you use a
          physical Bible, write a legend and keep it inside the cover. In Lux,
          rename the styles so their purposes remain clear.
        </li>
        <li>
          Highlight a verse or phrase when it clearly develops one of your
          themes. Add a short note only when the reason for the highlight might
          not be obvious later.
        </li>
        <li>
          Revisit the collection periodically. A digital system lets you filter
          every passage marked Attributes of God, Salvation, or Application,
          then open an individual result in context.
        </li>
      </ol>

      <p>
        Over time, the markings give you a visual overview when you return to a
        page, while the grouped notes help you trace a theme across Scripture.
        The categories act as a simple index to what you have read.
      </p>

      <h3 id="parallel-passages">Note parallel passages</h3>

      <p>
        Some events are recorded in several places. Jesus feeding the five
        thousand, for example, appears in Matthew 14:13-21, Mark 6:30-44, Luke
        9:10-17, and John 6:1-15. Reading the accounts together can reveal
        details and emphases you might miss when reading only one.
      </p>

      <p>
        When you find a parallel account, note its reference beside the passage
        so you can return to it easily. Bible footnotes and cross-references are
        useful places to find these connections. Keep the note short. Its job is
        to point you toward the related text, not replace reading it.
      </p>

      <p>
        For example, beside Matthew 14:13-21 you could write, “Parallel
        accounts: Mark 6:30-44, Luke 9:10-17, and John 6:1-15.” Read those
        passages while the first account is still fresh. If one contributes an
        important detail, add a brief observation beside the reference so you
        remember why the connection mattered.
      </p>

      <ArticleImage
        sources={[
          `${articleMediaPath}/cross_references.png`,
          `${articleMediaPath}/cross_reference_context.png`,
        ]}
        alt="Cross-references for Matthew 14:13 and the parallel account in Luke 9 in Lux"
        caption="Finding Luke's account of the feeding of the five thousand through the cross-references for Matthew 14:13."
      />

      <h2 id="reflect">Reflect: Retain and respond</h2>

      <p>
        In some seasons, you may want shorter daily readings that combine
        learning, reflection, encouragement, and application for something you
        are currently facing. Here the goal is not merely to mark an important
        verse. It is to understand what you read, express it in your own words,
        and decide how you will respond.
      </p>

      <h3 id="summarize">Summarize what you read</h3>

      <p>
        Summarizing tests whether you understood a passage well enough to
        explain it simply. The act of writing also makes you spend more time
        with its meaning, which can help you remember it. When you reread the
        passage months or years later, your summary gives you a record of what
        you noticed at that point in your life.
      </p>

      <p>
        A notebook works well for longer physical summaries because it keeps the
        margins around Scripture clear. In Lux, you can place summaries in a
        dedicated notebook and hide that notebook whenever you want those
        annotations out of the reading view. The summaries remain available when
        you are ready to revisit them.
      </p>

      <p>
        To write a summary, read the complete passage, identify its main
        movement, and explain it in two or three sentences without copying its
        wording. Then compare your summary with the passage and correct anything
        you overstated or missed.
      </p>

      <ArticleImage
        sources={[
          `${articleMediaPath}/summary_annotation.png`,
          `${articleMediaPath}/hide_summary_notebook.png`,
        ]}
        alt="A summary note on Mark 4 and the option to hide the Summaries notebook in Lux"
        caption="Saving a summary of Jesus calming the storm, then hiding the Summaries notebook from the reading view."
      />

      <h3 id="applications">Make applications accountable</h3>

      <p>
        A useful application is practical, actionable, and measurable. A broad
        intention such as “I will abide in Christ” may express a good desire,
        but it does not identify the action you will take or give you a clear
        way to know whether you followed it.
      </p>

      <p>
        Applications become more useful when you revisit them. Record what you
        intend to do, check your progress after a set time, and make changes if
        needed. You can track these in a paper notebook or use a consistent
        notebook or highlight style in Lux, then filter your annotations to
        review previous applications together.
      </p>

      <p>
        Include a person, place, time, or frequency whenever the passage allows
        it. Colossians 3:13 says to bear with one another and forgive as the
        Lord forgave us. A concrete response might be, “This week, I will
        contact the person I have been avoiding, acknowledge my part in our
        conflict, and begin a conversation about forgiveness and
        reconciliation.” Set a weekly or monthly time to review notes marked
        Application, ask what happened, and revise any commitment that was too
        vague to follow.
      </p>

      <ArticleImage
        sources={[
          `${articleMediaPath}/application_annotation_context.png`,
          `${articleMediaPath}/application_annotations.png`,
        ]}
        alt="An application note on Colossians 3:13 and annotations filtered by the Application style in Lux"
        caption="Reviewing a practical application in context next to other notes marked with the Application style."
      />

      <h2 id="study">Study: Preserve deeper discoveries</h2>

      <p>
        A study-focused reading may cover only a few verses. You might compare
        translations, examine Greek or Hebrew words, follow cross-references,
        and consult commentaries. The goal is depth: to understand the
        passage&apos;s language, context, argument, and implications carefully.
        Notes turn that research into a concise record you can understand when
        you return to the passage later.
      </p>

      <h3 id="word-studies">Record word studies</h3>

      <p>
        A word study can explore the Greek or Hebrew behind a translation, its
        morphology, the range described by a lexicon, and other places the word
        appears in Scripture. A commentary may help you understand how those
        details contribute to the passage.
      </p>

      <p>
        Do not copy every detail a tool provides. Note the findings that clarify
        this particular verse, along with enough information to retrace your
        work, such as the original word or Strong&apos;s number. Attaching the
        result to the word or phrase means you can recover the most useful part
        of the study the next time you read it.
      </p>

      <ArticleImage
        sources={[
          `${articleMediaPath}/interlinear.png`,
          `${articleMediaPath}/word_study_annotate.png`,
        ]}
        alt="The interlinear entry for remain in John 15:4 and a Word Study note in Lux"
        caption="Studying the word “remain” in the interlinear, then saving the findings with a Word Study style."
      />

      <h3 id="analysis">Capture your analysis</h3>

      <p>
        If you are studying for personal growth or preparing to lead a group,
        gather what you learn from the passage and its study resources, then
        write down the most important insights in your own words. A good
        analysis note is selective. It captures the passage&apos;s main point,
        important context, and the observations you would want available during
        a discussion.
      </p>

      <p>
        Keeping that summary attached to the passage makes preparation useful
        beyond a single meeting. When a related question comes up later, you can
        quickly return to the research you have already done instead of
        beginning again.
      </p>

      <p>
        Start with your own observations, then compare translations, follow
        relevant cross-references, and consult one or more commentaries. Record
        where an insight came from, especially when you quote or closely
        summarize another writer. Finally, combine the most helpful findings
        into a short explanation of the passage rather than leaving them as a
        disconnected list.
      </p>

      <ArticleImage
        sources={[
          `${articleMediaPath}/commentary.png`,
          `${articleMediaPath}/analysis_annotation.png`,
        ]}
        alt="Matthew Henry's commentary on Romans 12:2 and a note summarizing the analysis in Lux"
        caption="Consulting Matthew Henry's commentary on Romans 12:2, then saving the key findings beside the passage."
      />

      <h2 id="conclusion">Build a system that serves your reading</h2>

      <p>
        A thoughtful note-taking method can support almost any reason for
        opening the Bible, from learning its story for the first time to
        preparing an in-depth group study. The most useful system is not the one
        with the most colors, notebooks, or rules. It is the one that helps you
        read attentively and return to what you learned.
      </p>

      <p>
        Begin with your purpose, choose one or two practices that fit it, and
        experiment. Your method can change as your goals and seasons change.
        Keep it simple enough to sustain, and let your notes remain a tool that
        supports your time in Scripture.
      </p>

      <p>
        A practical starting system can be very small: choose whether
        today&apos;s goal is to Read, Reflect, or Study; choose paper, digital
        notes, or a combination; and begin with one of the two practices
        suggested for that goal. Add the second only if it would make the system
        more useful without making it harder to sustain. Decide when you will
        review your notes, then adjust the system after a few weeks. The best
        method is the one that continues helping you understand, remember, and
        respond to what you read.
      </p>
    </ArticlePage>
  );
}

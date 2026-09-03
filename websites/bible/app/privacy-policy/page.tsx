import { Metadata } from 'next';

import Page from '@/components/layout/Page';

export const metadata: Metadata = {
  title: 'Privacy Policy',
};

export default function PrivacyPolicyPage() {
  return (
    <Page>
      <div className="container py-16 lg:py-20">
        <article className="prose prose-invert mx-auto max-w-3xl prose-a:text-emphasis prose-headings:font-serif">
          <h1>Privacy Policy for Lux Bible</h1>
          <p>
            <strong>Effective Date:</strong> September 3, 2026
          </p>
          <p>
            Lux Bible (the “App”) is operated by <strong>JLogical LLC</strong>{' '}
            (“Company,” “we,” “our,” or “us”). This Privacy Policy explains how
            information is handled when you use the App.
          </p>

          <h2>1. A Privacy-Focused App</h2>
          <p>
            Lux does not require an account and does not collect your name,
            email address, or contact information through the App. Your notes,
            highlights, bookmarks, notebooks, reading history, Bible plan
            progress, reminders, and preferences are stored locally on your
            device.
          </p>
          <p>
            We do not send your notes, search terms, Bible plan names or reading
            details, selected Bible passages, or other user-created content to
            our analytics or crash-reporting services. We also do not assign an
            Analytics or Crashlytics user ID or link telemetry to an account.
          </p>

          <h2>2. Analytics and Reliability Information</h2>
          <p>
            We use Google Analytics for Firebase to understand how the App is
            used in aggregate and Firebase Crashlytics to identify crashes and
            other software errors. This collection is enabled in production
            versions of the App and disabled in developer debug builds.
          </p>
          <p>Analytics may collect:</p>
          <ul>
            <li>
              Basic usage information, such as app opens, sessions, and visits
              to pages identified by fixed, content-free names
            </li>
            <li>
              Whether certain actions occurred, such as starting audio,
              starting or completing a Bible plan day, using search, opening
              Verse of the Day or a local notification, customizing a toolbar,
              opening a community link, and starting, completing, or skipping onboarding
            </li>
            <li>
              Basic app and device information, such as app version, device
              type, operating system, language, session information, and
              approximate geographic information
            </li>
            <li>
              A randomly generated app-instance identifier used to distinguish
              installations and calculate aggregate usage metrics
            </li>
          </ul>
          <p>
            Lux sends its custom analytics events without parameters. Page
            names and events do not include Bible references, search terms,
            plan names, note content, or local record identifiers.
          </p>
          <p>Crash reports may include:</p>
          <ul>
            <li>Crash details, stack traces, and error messages</li>
            <li>The time and state of the App when an error occurred</li>
            <li>
              App version and technical device information such as device
              model, operating system, processor architecture, memory, and
              storage information
            </li>
            <li>
              Random installation and session identifiers used to group and
              deduplicate reports and calculate how many installations were
              affected
            </li>
          </ul>
          <p>
            Analytics events may also appear as Crashlytics breadcrumbs to help
            us understand the sequence of App actions before an error. Because
            Lux events use fixed names without content parameters, these
            breadcrumbs do not include the private content listed above.
          </p>

          <h2>3. Advertising and Cross-App Tracking</h2>
          <p>
            Lux does not show ads and does not use analytics for advertising,
            ad personalization, profiling, or tracking you across other
            companies&apos; apps and websites.
          </p>
          <ul>
            <li>
              On Android, Lux removes permission to access the Android
              Advertising ID and related Android advertising services, and
              disables Advertising ID collection in Analytics.
            </li>
            <li>
              On Apple platforms, Lux uses the Firebase Analytics library that
              does not include IDFA support and also disables collection of the
              Identifier for Vendor (IDFV).
            </li>
            <li>
              On both platforms, Lux denies consent signals for ad storage, ad
              user data, and ad-personalization signals.
            </li>
          </ul>
          <p>
            The random installation identifiers described in Section 2 are
            specific to an installed copy of the App. They are not Android
            Advertising IDs, IDFAs, or IDFVs.
          </p>

          <h2>4. Information Stored on Your Device</h2>
          <p>
            Local App data is not backed up or synchronized by JLogical LLC. If
            you uninstall the App, this data may be deleted according to your
            device&apos;s operating system and backup settings.
          </p>

          <h2>5. Online Features and Security</h2>
          <p>
            Some features require an internet connection, including retrieving
            licensed Bible translations and streaming audio. A request for
            online content necessarily includes the requested resource, such as
            a chapter or audio file, along with limited network information such
            as an IP address and basic app or device information. These requests
            may be processed by our infrastructure and the content provider
            needed to fulfill the request.
          </p>
          <p>
            Lux also uses Firebase App Check to protect our online services from
            abuse and unauthorized access. Depending on your platform, App
            Check and its attestation provider may process app and device
            information, integrity or attestation material, and short-lived
            security tokens. We use this information to provide and secure App
            functionality, not for advertising or cross-app tracking.
          </p>
          <p>
            Bible plan and Verse of the Day reminders are scheduled locally on
            your device. Lux does not use Firebase Cloud Messaging or another
            remote push-notification service to deliver them.
          </p>

          <h2>6. Service Providers, Retention, and Processing</h2>
          <p>
            Google processes Analytics, Crashlytics, and App Check information
            on our behalf. Firebase services may process information on global
            infrastructure. Google states that Firebase encrypts data in
            transit and that Crashlytics data is also encrypted at rest.
          </p>
          <p>
            Firebase states that Crashlytics retains crash stack traces and
            associated installation identifiers for 90 days before beginning
            removal from live and backup systems. Analytics information is
            retained according to our Google Analytics property settings and
            Google&apos;s applicable terms and policies. App Check and its
            attestation providers retain information according to their
            applicable service terms.
          </p>
          <p>
            Learn more in{' '}
            <a href="https://firebase.google.com/support/privacy">
              Google&apos;s Privacy and Security in Firebase documentation
            </a>{' '}
            and{' '}
            <a href="https://policies.google.com/privacy">
              Google&apos;s Privacy Policy
            </a>
            .
          </p>

          <h2>7. Children&apos;s Privacy</h2>
          <p>
            The App does not knowingly collect names, contact information, or
            other information that directly identifies children under the age
            of 13, or the applicable age in their jurisdiction. The limited
            technical, usage, reliability, and security information described
            above may still be processed when a child uses the App.
          </p>

          <h2>8. Changes to This Privacy Policy</h2>
          <p>
            We may update this Privacy Policy from time to time. Any changes
            will be reflected by updating the Effective Date above.
          </p>

          <h2>9. Contact Information</h2>
          <p>
            If you have any questions or requests regarding this Privacy Policy,
            you may contact:
          </p>
          <p>
            JLogical LLC
            <br />
            Email: support@jlogical.com
            <br />
            Website:{' '}
            <a href="https://www.luxbible.app">https://www.luxbible.app</a>
          </p>
        </article>
      </div>
    </Page>
  );
}

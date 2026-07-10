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
            <strong>Effective Date:</strong> February 21, 2026
          </p>
          <p>
            Lux Bible (the “App”) is operated by <strong>JLogical LLC</strong>{' '}
            (“Company,” “we,” “our,” or “us”).
          </p>
          <p>
            This Privacy Policy explains how we handle information in connection
            with your use of the App.
          </p>

          <h2>1. Information We Collect</h2>
          <p>
            We do not collect, store, transmit, or process any personal
            information from users.
          </p>
          <p>Specifically:</p>
          <ul>
            <li>No account creation is required.</li>
            <li>
              We do not collect names, email addresses, or contact information.
            </li>
            <li>We do not collect analytics data.</li>
            <li>We do not use tracking technologies.</li>
            <li>We do not collect location data.</li>
            <li>We do not collect device identifiers.</li>
            <li>We do not use advertising SDKs.</li>
          </ul>

          <h2>2. Data Stored on Your Device</h2>
          <p>
            The App may store certain information locally on your device to
            provide functionality, such as:
          </p>
          <ul>
            <li>Bookmarks</li>
            <li>Highlights</li>
            <li>Reading history</li>
            <li>
              App preferences (e.g., theme settings, toolbar customization)
            </li>
          </ul>
          <p>
            This information is stored only on your device and is not
            transmitted to JLogical LLC.
          </p>
          <p>
            If you uninstall the App, locally stored data may be deleted
            according to your device’s operating system policies.
          </p>

          <h2>3. Internet Connectivity</h2>
          <p>
            The App may use an internet connection to retrieve Bible text,
            commentary, Strong’s data, or related resources necessary for
            functionality.
          </p>
          <p>
            We do not log, monitor, or associate your activity with any
            personally identifiable information.
          </p>

          <h2>4. Third-Party Services</h2>
          <p>
            The App does not integrate third-party analytics services,
            advertising networks, or account systems that collect user data.
          </p>

          <h2>5. Children’s Privacy</h2>
          <p>
            The App does not knowingly collect personal information from
            children under the age of 13 (or the applicable age in your
            jurisdiction). Because we do not collect personal information, no
            such data is stored or processed.
          </p>

          <h2>6. Changes to This Privacy Policy</h2>
          <p>
            We may update this Privacy Policy from time to time. Any changes
            will be reflected by updating the Effective Date above.
          </p>

          <h2>7. Contact Information</h2>
          <p>
            If you have any questions regarding this Privacy Policy, you may
            contact:
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

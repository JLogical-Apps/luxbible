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
            <strong>Effective Date:</strong> July 26, 2026
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
            We do not collect information that directly identifies you, such as
            your name, email address, or contact information.
          </p>
          <p>
            When the App connects to our online services, limited technical
            information is transmitted and processed to deliver the requested
            content and protect those services. This may include network
            information such as an IP address, basic app and device information,
            app or device attestation material, integrity tokens, and
            short-lived security tokens.
          </p>
          <p>
            We use this information only to provide App functionality and for
            security and fraud prevention, including verifying that requests
            come from the authentic App and preventing abuse or unauthorized
            access. We do not use it for advertising, analytics, profiling, or
            tracking.
          </p>
          <p>Specifically:</p>
          <ul>
            <li>No account creation is required.</li>
            <li>
              We do not collect names, email addresses, or contact information.
            </li>
            <li>
              We do not use an analytics product to measure how people use the
              App.
            </li>
            <li>We do not use tracking technologies.</li>
            <li>We do not collect location data.</li>
            <li>
              Technical device and integrity information is processed only for
              App functionality, security, and fraud prevention.
            </li>
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
            Requests necessarily transmit the requested resource and limited
            network and security information. We do not use this information to
            create a profile of you or track your activity for advertising or
            analytics.
          </p>

          <h2>4. Third-Party Services</h2>
          <p>
            The App uses Firebase App Check, a service provided by Google, to
            help protect our backend services from abuse, fraud, and
            unauthorized access. Depending on your platform, Firebase App Check
            and its attestation providers may process basic app and device
            information, a DeviceCheck token or App Attest attestation and
            assertion objects on Apple platforms, a Play Integrity token on
            Android, and App Check tokens sent with protected requests.
          </p>
          <p>
            Google may also process basic SDK, app, platform, and operating
            system information to provide, maintain, and improve Firebase
            services. Google states that this information is not linked to a
            user or device identifier.
          </p>
          <p>
            Firebase states that App Check attestation material is not retained
            by App Check. App Check tokens are generally not retained by
            Firebase services, except that tokens used with replay protection
            may be stored for up to 30 days. Attestation providers may retain
            information according to their own terms. Google states that Play
            Integrity data is deleted after a fixed retention period.
          </p>
          <p>
            Firebase may process information on global infrastructure. You can
            learn more in{' '}
            <a href="https://firebase.google.com/support/privacy">
              Google’s Privacy and Security in Firebase documentation
            </a>
            .
          </p>
          <p>
            We do not integrate third-party analytics products, advertising
            networks, or account systems that collect user data.
          </p>

          <h2>5. Children’s Privacy</h2>
          <p>
            The App does not knowingly collect names, contact information, or
            other information that directly identifies children under the age of
            13 (or the applicable age in your jurisdiction). The limited
            technical information described above may be processed for App
            functionality, security, and fraud prevention.
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

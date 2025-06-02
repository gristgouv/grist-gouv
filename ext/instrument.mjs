import * as Sentry from "@sentry/node";
// Ensure to call this before importing any other modules!
Sentry.init({
  dsn: "https://examplePublicKey@o0.ingest.sentry.io/0",
  // Adds request headers and IP for users, for more info visit:
  // https://docs.sentry.io/platforms/javascript/guides/node/configuration/options/#sendDefaultPii
  sendDefaultPii: true,
});

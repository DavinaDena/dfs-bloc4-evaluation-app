import type { Metadata } from "next";
import React from "react";

export const metadata: Metadata = {
  title: "OpsTrack Dispatch Dashboard",
  description: "Supervision temps reel des interventions terrain.",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="fr">
      <body
        style={{
          margin: 0,
          fontFamily: "Georgia, serif",
          background:
            "radial-gradient(circle at top right, #d9efe8 0, transparent 20%), linear-gradient(180deg, #f4efe8 0%, #ebe4d8 100%)",
          color: "#1f2933",
        }}
      >
        {children}
      </body>
    </html>
  );
}

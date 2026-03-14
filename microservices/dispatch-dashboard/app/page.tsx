import { fetchTickets } from "../lib/api";

export default async function Page() {
  const tickets = await fetchTickets();

  return (
    <main style={{ maxWidth: 1100, margin: "0 auto", padding: "40px 24px" }}>
      <p style={{ textTransform: "uppercase", letterSpacing: "0.1em", color: "#52606d", fontSize: 12 }}>
        OpsTrack dispatch dashboard
      </p>
      <h1 style={{ fontSize: 42, marginTop: 0 }}>Pilotage temps reel des interventions</h1>
      <p style={{ maxWidth: 700, color: "#52606d", lineHeight: 1.6 }}>
        Ce microservice Next.js consomme l&apos;API Laravel pour afficher les incidents ouverts et
        alimenter la supervision du superviseur de session.
      </p>

      <section
        style={{
          marginTop: 28,
          display: "grid",
          gap: 16,
          gridTemplateColumns: "repeat(auto-fit, minmax(240px, 1fr))",
        }}
      >
        {tickets.map((ticket: any) => (
          <article
            key={ticket.id}
            style={{
              background: "#fffdf8",
              border: "1px solid #d8d0c5",
              borderRadius: 18,
              padding: 18,
              boxShadow: "0 10px 24px rgba(31,41,51,.06)",
            }}
          >
            <div style={{ fontSize: 12, letterSpacing: "0.08em", textTransform: "uppercase", color: "#64748b" }}>
              {ticket.reference}
            </div>
            <h2 style={{ fontSize: 22 }}>{ticket.title}</h2>
            <p style={{ color: "#52606d" }}>
              {ticket.site?.name} · {ticket.site?.city}
            </p>
            <p style={{ marginBottom: 0 }}>
              <strong>Priorite:</strong> {ticket.priority}
              <br />
              <strong>Statut:</strong> {ticket.status}
            </p>
          </article>
        ))}
      </section>
    </main>
  );
}

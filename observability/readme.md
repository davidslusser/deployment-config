


observability/
├── docker-compose.yml
├── prometheus/
│   └── prometheus.yml
├── loki/
│   └── config.yml
├── promtail/
│   └── config.yml
└── tempo/
    └── config.yml



docker-compose.yml → main stack definition (Prometheus, Grafana, Loki, Promtail, Tempo).

prometheus/prometheus.yml → scrape targets + retention (30 days).

loki/config.yml → log storage + 30-day retention.

promtail/config.yml → log shipper, auto-discovers Docker logs.

tempo/config.yml → tracing config with 30-day retention.


Start the Stack
docker compose up -d

Access the Tools

Grafana → http://<your-vps-ip>:3000 (login: admin / admin)

Prometheus → http://<your-vps-ip>:9090

Loki API → http://<your-vps-ip>:3100/ready (check readiness)

Tempo API → http://<your-vps-ip>:3200/ready

In Grafana → check that Prometheus, Loki, Tempo datasources are already provisioned.

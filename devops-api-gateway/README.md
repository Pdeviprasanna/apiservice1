## DevOps-Driven API Gateway Management System (Prototype - Phase 1)

This is a minimal Stage 1 prototype using Kong Gateway in DB-less mode with a sample upstream echo service. It lays groundwork for later phases: CI/CD, security policies, analytics/monitoring, and version control.

### Prerequisites
- Docker and Docker Compose

### Quickstart
```bash
cd devops-api-gateway
docker compose up -d
# Wait ~10s for Kong to be healthy

# Call the proxied echo API (requires API key)
curl -sS http://localhost:8000/echo -H 'apikey: DEMO-API-KEY' | jq .

# Rate limit is 60 req/min per consumer on this route. Exceeding returns 429.
```

- Kong Admin API: http://localhost:8001
- Upstream echo service (bypassing gateway): http://localhost:8080

### What’s included
- `docker-compose.yml`: Kong in DB-less mode + upstream echo container
- `config/kong.yml`: Declarative configuration
  - Service/route: `/echo`
  - Global `key-auth` plugin
  - Per-route `rate-limiting` (60 req/min, local policy)
  - Demo consumer `demo-consumer` with API key `DEMO-API-KEY`
- `openapi/echo.yaml`: Minimal OpenAPI 3.0 spec for the proxied echo API

### Roadmap Alignment
- Phase 1: API gateway infrastructure (this prototype)
- Phase 2: CI/CD for declarative config and specs
- Phase 3: Expanded security (OAuth 2.0, mTLS), advanced rate limiting
- Phase 4: Analytics/monitoring (Prometheus/Grafana, ELK/Splunk)
- Phase 5: Tests and deployment hardening

### Next Steps (suggested)
- Add GitHub Actions to validate `kong.yml` with `deck` and lint `openapi/echo.yaml` on PRs
- Introduce versioned routes, e.g., `/v1/echo` and `/v2/echo`, with backward compatibility
- Add observability: enable Prometheus metrics, wire to Grafana dashboards
- Integrate centralized logging to Elastic Stack or Splunk
- Add OAuth 2.0 authorization server or OIDC provider; swap route auth to JWT/OIDC

### Standards
- OpenAPI Specification (OAS) for API definitions
- ISO/IEC 27001-aligned controls to be elaborated in later phases (access control, change mgmt)

### Cleanup
```bash
docker compose down -v
```
## DevOps-Driven API Gateway Management System (Phase 1 Prototype)

This is a minimal Stage 1 prototype that sets up API gateway infrastructure using Kong in DB-less mode and a simple upstream service. It is designed to be imported into Eclipse as a plain project (no code build required for Phase 1).

### What’s included
- Kong Gateway (DB-less) with declarative config (`infra/kong.yml`)
- Simple upstream service (`hello-service`) using `nginxdemos/hello`
- An example OpenAPI spec for the `GET /hello` API (`openapi/hello.yaml`)

### How it works
- `Kong` listens on:
  - Admin API: `http://localhost:8001`
  - Proxy (HTTP): `http://localhost:8000`
- `hello-service` listens on `http://localhost:8080`
- Kong routes `GET /hello` to the upstream service

### Run locally (Docker Compose)
1. Prerequisites: Docker and Docker Compose installed.
2. From the project root:
   ```sh
   cd infra
   docker compose up -d
   ```
3. Test the proxy through Kong:
   ```sh
   curl -i http://localhost:8000/hello
   ```
   You should see a 200 response from the upstream.
4. Stop the stack:
   ```sh
   docker compose down
   ```

### Import into Eclipse
- File → Import → General → Existing Projects into Workspace → Select the project root directory → Finish.
- You can keep using Eclipse for documentation, roadmap, and config editing in Phase 1. Application code and CI/CD will be added in later phases.

### Roadmap (from prompt)
- Phase 1: Set up API gateway infrastructure. (this project)
- Phase 2: Develop CI/CD pipelines for API deployment.
- Phase 3: Implement security and rate-limiting policies (OAuth, API keys, rate limits).
- Phase 4: Add analytics and monitoring capabilities (Elastic Stack, Splunk).
- Phase 5: Test and deploy the API gateway management system.

### Standards
- OpenAPI Specification (OAS) for API definitions (`openapi/hello.yaml`).
- ISO/IEC 27001 principles considered from Phase 3 onward (security hardening, policies, access control, audit).

### Next steps (suggested)
- Add a GitHub Actions workflow to validate Kong declarative config and OpenAPI.
- Add security plugins (Key Auth, Rate Limiting) in `infra/kong.yml`.
- Add observability stack (e.g., `Prometheus + Grafana`, or ship logs/metrics to `Elastic/Splunk`).
# helm-charts

Helm charts for my cluster, published to GHCR as OCI artifacts.

These are reusable templates. The values for each app and environment live in a
separate private repository.

| Chart | What it deploys |
|---|---|
| [app-template](charts/app-template) | One app: Deployment, Service, Ingress and friends |
| [argocd-template](charts/argocd-template) | The Argo CD Applications for the applications namespace |

## Releasing

Bump `version` in the chart's `Chart.yaml` and merge to `main`. The release
workflow publishes any version that is not in the registry yet:

```
oci://ghcr.io/adrian-olias/charts/<chart>
```

## Testing locally

```bash
helm lint --strict charts/app-template
helm lint --strict charts/argocd-template --set name=ci,env=ci,repo.url=https://example.com/repo.git
```

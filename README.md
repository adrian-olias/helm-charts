# helm-charts

Charts for my cluster, published to GHCR as OCI artifacts.

| Chart | What it deploys |
|---|---|
| [app-template](charts/app-template) | One app: Deployment, Service, Ingress and friends |
| [argocd-template](charts/argocd-template) | The Argo CD Applications of a namespace, plus the namespace and its guardrails |

Neither is installed directly. In
[helm-charts-wrappers](https://github.com/adrian-olias/helm-charts-wrappers) each one is used
by a wrapper: a small chart that depends on it and only carries values.

| Template (here) | Wrapper (in helm-charts-wrappers) |
|---|---|
| `app-template` | `app-wrapper/<app>-<env>/`: one folder per app and environment |
| `argocd-template` | `argocd-wrapper/`: one `<name>-<env>.yaml` per namespace |

## Releasing

Bump `version` in the chart's `Chart.yaml` and merge to `main`. The release
workflow checks every chart and publishes any version that is not in the
registry yet:

```
oci://ghcr.io/adrian-olias/charts/<chart>
```

The workflow file also explains how to do it by hand.

## Testing locally

```bash
helm lint --strict charts/app-template
helm lint --strict charts/argocd-template --set name=ci,env=ci,repo.url=https://example.com/repo.git
```

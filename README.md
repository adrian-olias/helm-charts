# helm-charts

Helm charts for my cluster, published to GHCR as OCI artifacts.

These are reusable templates. `helm-charts-wrappers` pins a version of each chart and
holds the values for each app and environment. Argo CD renders them from there.

| Chart | What it deploys |
|---|---|
| [app-template](charts/app-template) | One app: Deployment, Service, Ingress and friends |
| [argocd-template](charts/argocd-template) | The Argo CD Applications for the applications namespace |

## Releasing

Bump `version` in the chart's `Chart.yaml` and merge to `main`. The release
workflow publishes any version that is not in the registry yet:

```
oci://ghcr.io/<owner>/charts/<chart>
```

## Testing locally

```bash
helm lint --strict charts/app-template
helm lint --strict charts/argocd-template --set name=ci,env=ci,repo.url=https://example.com/repo.git
```

## Argo CD UI

```bash
ssh -t -L 8080:127.0.0.1:8080 vps "sudo k3s kubectl port-forward -n argocd svc/argocd-server 8080:443"
```

Open https://localhost:8080 and accept the self-signed certificate. User: `admin`.

## Useful kubectl commands

Run them on the VPS with `sudo k3s kubectl`:

```bash
sudo k3s kubectl get applications -n argocd              # Argo CD apps and their sync status
sudo k3s kubectl get pods -A                             # everything running in the cluster
sudo k3s kubectl get events -n <namespace> --sort-by=.lastTimestamp   # recent problems
sudo k3s kubectl logs -n <namespace> deploy/<app> --tail=100
sudo k3s kubectl describe pod -n <namespace> <pod>       # why a pod is not ready
sudo k3s kubectl rollout restart deploy/<app> -n <namespace>
```
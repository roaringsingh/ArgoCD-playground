kind create cluster --name argocd-test --config ~/E2E/argocd/kind-config.yaml
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# podman save docker.io/library/redis:7.2.7-alpine -o redis.tar
kind load image-archive ~/E2E/argocd/ArgoCD-playground/redis.tar --name argocd-test
kubectl -n argocd set image deployment argocd-redis redis=redis:7.2.7-alpine

sleep 180
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null &

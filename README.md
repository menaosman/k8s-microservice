# Microservice Deployment on Kubernetes (AWS EKS via Terraform)

This repository contains everything you need to build a Python microservice Docker image, provision AWS EKS with Terraform, and deploy the app to Kubernetes via `kubectl` or GitHub Actions.

## Quickstart

1) **Set your repo secrets (GitHub → Settings → Secrets and variables → Actions):**
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_PASSWORD`

2) **Build & run locally**

```bash
docker build -t $DOCKERHUB_USERNAME/solar-system:latest .
docker run --rm -p 3000:5000 $DOCKERHUB_USERNAME/solar-system:latest
# open http://localhost:3000
```

3) **Terraform (from `terraform/`)**

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

4) **Update kubeconfig & deploy**

```bash
aws eks update-kubeconfig --region $(terraform output -raw region) --name $(terraform output -raw cluster_name)
kubectl apply -f ../k8s/deployment.yml
kubectl apply -f ../k8s/service.yml
kubectl get pods -o wide
kubectl get svc
```

5) **Get external URL**

```bash
kubectl get svc microservice-service
```

---

## Repo Layout

```
app/
  main.py
Dockerfile
requirements.txt
k8s/
  deployment.yml
  service.yml
terraform/
  versions.tf
  variables.tf
  terraform.tfvars
  main.tf
  outputs.tf
.github/
  workflows/
    workflow.yml
```

## Notes
- The app listens on port **5000** in the container; the Service exposes port **80** externally.
- Adjust `terraform/terraform.tfvars` to your region, VPC CIDR, cluster name, etc.
- The GitHub Actions workflow supports both automatic deploys on push-to-main and manual runs (including destroy).


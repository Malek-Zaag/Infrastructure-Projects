# Infrastructure Projects

AWS, Terraform, Jenkins, and local Kubernetes lab examples.

| Project | Path | What it does |
|---|---|---|
| Terraform VPC | `terraform-vpc-project/` | VPC + EC2 + Nginx on AWS |
| Terraform Lambda | `terraform-lambda-project/terraform-example/` | Lambda + API Gateway via Terraform |
| AWS SAM Lambda | `terraform-lambda-project/myTestFunction-stack/` | Lambda via AWS SAM |
| Jenkins | `Jenkins-Project/` | Jenkins in Docker |
| Local Kubernetes | `kuberentes-config.sh` | Minikube cluster startup |

---

## Terraform VPC

```bash
cd terraform-vpc-project
terraform init && terraform apply
terraform destroy  # cleanup
```

## Terraform Lambda

```bash
cd terraform-lambda-project/terraform-example/infra
terraform init && terraform apply
curl "$(terraform output -raw base_url)/hello"
terraform destroy
```

## AWS SAM Lambda

```bash
cd terraform-lambda-project/myTestFunction-stack
sam build
sam local invoke LambdaFunctionFunctionmyTestFunction
sam deploy --guided
```

## Jenkins

```bash
# Basic
docker run -d --name jenkins --restart unless-stopped \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts

# With Docker socket access
docker run -d --name jenkins --restart unless-stopped \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts
```

## Local Kubernetes (Minikube)

```bash
./kuberentes-config.sh   # deletes existing cluster, starts new one (6 CPUs, 8GB RAM)
```


### 4. docs/automatisation_github_actions.md

```markdown
# Automatisation avec GitHub Actions

## Introduction
Utilisation de GitHub Actions pour automatiser le déploiement de l'infrastructure et de l'application.

## Configuration des Workflows
1. Créez un fichier `.github/workflows/deploy.yml` :
   ```yaml
   name: Deploy to AWS

   on:
     push:
       branches:
         - main

   jobs:
     deploy:
       runs-on: ubuntu-latest

       steps:
       - name: Checkout code
         uses: actions/checkout@v2

       - name: Set up Terraform
         uses: hashicorp/setup-terraform@v1

       - name: Terraform Init
         run: terraform init

       - name: Terraform Apply
         run: terraform apply -auto-approve

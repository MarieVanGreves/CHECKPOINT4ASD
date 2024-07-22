
### 3. docs/infrastructure_aws_terraform.md

```markdown
# Infrastructure AWS avec Terraform

## Introduction
Utilisation de Terraform pour créer une infrastructure AWS.

## Pré-requis
- Un compte AWS avec les permissions nécessaires.
- Terraform installé sur votre machine.

## Configuration de Terraform
1. Initialisez un nouveau répertoire Terraform :
   ```sh
   mkdir terraform-aws
   cd terraform-aws
   terraform init
2. Créez un fichier main.tf pour définir les ressources AWS :
   ```sh
   provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
3. Appliquez la configuration :
   ```sh
   terraform apply


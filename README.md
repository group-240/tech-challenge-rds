# tech-challenge-rds

This repository contains a Terraform-based boilerplate to provision AWS Networking (VPC) and an RDS PostgreSQL instance, plus a GitHub Actions workflow to automate plan/apply.

Important notes
- Terraform state backend in `terraform/main.tf` is commented out. Create an S3 bucket and DynamoDB table for locking, then uncomment the backend block.
- RDS is provisioned in private subnets. To run `scripts/init.sql` against the database you'll need a bastion/SSH tunnel or a migration tool (Flyway/Liquibase) from within your application.

Getting started (local)

1. Install Terraform (>= 1.x) and configure your AWS CLI credentials.
2. From repository root:

	cd terraform
	terraform init

3. Provide DB credentials as environment variables for local runs:

	export TF_VAR_db_username="your_admin_user"
	export TF_VAR_db_password="your_secure_password"

4. Run a plan:

	terraform plan -var="db_username=${TF_VAR_db_username}" -var="db_password=${TF_VAR_db_password}"

5. Apply (be careful; this creates real AWS resources):

	terraform apply -auto-approve -var="db_username=${TF_VAR_db_username}" -var="db_password=${TF_VAR_db_password}"

CI/CD

The workflow at `.github/workflows/terraform-deploy.yml` will run `terraform plan` for pull requests and `terraform apply` on pushes to `main`. It expects the following GitHub Secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `DB_USERNAME` (used to populate TF_VAR_db_username)
- `DB_PASSWORD` (used to populate TF_VAR_db_password)

Security and production considerations
- For production, enable `deletion_protection` and disable `skip_final_snapshot`.
- Use AWS IAM roles with OIDC for the GitHub runner instead of long-lived secrets when possible.
- Consider using a dedicated subnet and stricter SG rules for administrative access.

Database initialization

The SQL schema is located at `scripts/init.sql`. Because the DB is private, prefer application migration tooling (Flyway/Liquibase) or run the script through a bastion host.

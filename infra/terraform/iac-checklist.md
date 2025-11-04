# IaC Checklist — Safe Terraform Workflow

## Initialization — `terraform init`

**Purpose:** Initialize backend, install providers, and set up the working directory.

### Checklist
- Confirm you're in the intended working directory.  
- Confirm backend configuration points to the correct remote state (workspace, bucket, or table).  
- Run with upgrade when updating providers:  
  ```bash
  terraform init -upgrade

## Planning — `terraform plan`

**Purpose:** preview changes; create a portable plan file to apply later.

### Checklist
- Always produce a saved plan file for review and repeatable apply:
  ```bash
  terraform plan -out=tfplan.binary -input=false
- For PR or code review, convert plan to human-readable output or run terraform show -json tfplan.binary for programmatic checks.

### Review step (manual):
- Confirm create, update, delete actions and counts.
- Check for resource names that might affect production systems (databases, load balancers, VPCs).

## Applying safely — `terraform apply`

**Purpose:** make changes predictable and auditable.

### Checklist
- apply from a saved plan file (guarantees exact actions):
  ```bash
  terraform apply -input=false tfplan.binary
- Do not use `terraform apply -auto-approve` for production; require manual approval or automated gated approvals.

## Safe destroy patterns

**Purpose:** deliberate removal of resources.

### Checklist
- Treat `terraform destroy` as a **dangerous operation** — require explicit approvals
- Produce a destroy plan and save it:
  ```bash
  terraform plan -destroy -out=tfplan.destroy -input=false
  terraform show -json tfplan.destroy > tfplan.destroy.json
- Review destroy plan carefully: ensure only intended resources are targeted.
- For production, prefer resource-by-resource deletion and database dumps before destroying.
- Use `-target` to destroy a specific resource if needed, but be cautious: this can leave orphaned dependencies.
# Learn Terraform variables

You can use input variables to customize your Terraform configuration with
values that can be assigned by end users of your configuration. Input variables
allow users to re-use and customize configuration by providing a consistent
interface to change how a given configuration behaves.

Follow along with this [Learn Terraform variables](https://developer.hashicorp.com/terraform/tutorials/configuration-language/variables) tutorial.

## Learning notes

### Declaring and assigning inputs

The exercise now uses root input variables for the AWS region, VPC and subnet
CIDRs, subnet and EC2 instance counts, VPN gateway toggle, and resource tags.
The subnet counts select entries from the CIDR lists. Tag validation checks the
length and characters of the project and environment names used in resource
names.

`variables.tf` declares `ec2_instance_type` as a string without a default, so
each run needs a value. The earlier plan failed because the variable file was
named `terraform.auto.tvars`. The current local file is named
`terraform.auto.tfvars`. Terraform auto-loads files ending in `.auto.tfvars`
or `.auto.tfvars.json`. For example, a local `terraform.auto.tfvars` could
contain the following example value. Terraform also loads `terraform.tfvars`
and `terraform.tfvars.json` automatically in the root module directory. For
local CLI runs, auto-loaded files are read in lexical order after the
conventional files. Explicit CLI `-var` and `-var-file` options take
precedence over automatic files, environment variables, and defaults.

```hcl
ec2_instance_type = "t2.micro"
```

An explicit `-var-file=dev.tfvars` can supply values from a differently named
file. In HCP Terraform you can also set `ec2_instance_type` as a **Terraform
variable** in the workspace. For remote auto-loading, the file must be present
in the configuration uploaded for the run. A Git-backed workspace only gets
the files in its checked-out configuration, so use workspace variables for
values kept out of Git.

[Terraform input variables](https://developer.hashicorp.com/terraform/language/values/variables) ·
[HCP Terraform workspace variables](https://developer.hashicorp.com/terraform/cloud-docs/variables/managing-variables)

### Saved plans and remote execution

The `cloud` block selects an HCP Terraform workspace. For a separate copy, set
the organisation and workspace to your own and select remote execution in HCP
Terraform before initialising the configuration. With a CLI-driven workspace,
the CLI uploads the configuration and streams the run output from HCP
Terraform.

```bash
terraform plan -out=variables-review.tfplan
terraform show variables-review.tfplan
```

`-out` sets the filename. To apply an approved saved plan, run
`terraform apply variables-review.tfplan`. With HCP Terraform remote execution
and Terraform CLI 1.6 or later, the local file refers to a plan stored in the
same HCP Terraform workspace. This workflow requires a workspace without a
linked VCS repository. In a VCS-linked workspace, review and approve the run
in HCP Terraform. Keep saved plans, remote references, and plan JSON exports
out of Git. Use the `.tfplan` suffix even though Terraform also accepts names
without an extension.

[HCP Terraform CLI-driven runs](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/cli)

### AWS authentication for remote runs

In AWS IAM, register `https://app.terraform.io` as the OIDC provider for the
standard HCP Terraform hostname. Allow `sts:AssumeRoleWithWebIdentity` and
require the expected audience (`aws.workload.identity` by default). Scope
the subject to `organization:<org>:project:<project>:workspace:<workspace>:run_phase:<phase>`
with the exact workspace identity. If using separate roles, restrict each
trust policy to its corresponding `plan` or `apply` phase and grant only the
AWS permissions that phase needs.

In HCP Terraform, set `TFC_AWS_PROVIDER_AUTH=true` and
`TFC_AWS_RUN_ROLE_ARN` to the run role ARN as **environment variables**.
Set `TFC_AWS_PLAN_ROLE_ARN` and `TFC_AWS_APPLY_ROLE_ARN` instead of the
shared run role when using separate roles for both phases. Remove static
AWS access-key environment variables from that workspace when switching to
OIDC. HCP Terraform exchanges its identity token for short-lived AWS
credentials during the run. `terraform login` authenticates the CLI to HCP
Terraform, and a local AWS login applies to local execution.

[HashiCorp's AWS OIDC setup guide](https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials/aws-configuration)

### Verification

- `terraform validate` passed on the local working configuration.
- The local saved plan files contain HCP Terraform run references. A reference
  alone does not establish the run outcome.
- Successful OIDC authentication and any apply or destroy outcome remain
  unverified.

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
contain:

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
same HCP Terraform workspace. Keep local saved plans and remote plan references
out of Git. Use the `.tfplan` suffix even though Terraform also accepts names
without an extension.

[HCP Terraform CLI-driven runs](https://developer.hashicorp.com/terraform/cloud-docs/workspaces/run/cli)

### AWS authentication for remote runs

For OIDC, configure an AWS IAM OIDC identity provider for HCP Terraform and an
IAM role with the permissions needed by the exercise. Scope its trust policy
to the expected token audience and the HCP organisation, project, workspace,
and run phase. In HCP Terraform, set `TFC_AWS_PROVIDER_AUTH=true` and
`TFC_AWS_RUN_ROLE_ARN` to the IAM role ARN as **environment variables**.
HCP Terraform uses the workload identity token to obtain short-lived AWS
credentials for the remote run. Local AWS CLI credentials are separate from
the remote runner's credentials.

[HashiCorp's AWS OIDC setup guide](https://developer.hashicorp.com/terraform/cloud-docs/dynamic-provider-credentials/aws-configuration)

### Verification

- `terraform validate` passed on the local working configuration.
- The local saved plan files contain HCP Terraform run references. A reference
  alone does not establish the run outcome.
- Successful OIDC authentication and any apply or destroy outcome remain
  unverified.

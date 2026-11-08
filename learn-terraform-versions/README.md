## Learn Terraform Versions

Learn how to manage different Terraform versions as part of a team.

Follow along with the tutorials for [Terraform Open Source](https://developer.hashicorp.com/terraform/tutorials/configuration-language/versions) or [Terraform Cloud](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-versions).

## What changed in this lab

The upstream exercise targeted Terraform `~> 1.1.9`. The local lab changed
`required_version` to `~> 1.17.1`, which accepts patch releases from 1.17.1
up to, but excluding, 1.18.0. This constraint checks the Terraform CLI version.
The entries under `required_providers` separately constrain plugin versions.

The committed `.terraform.lock.hcl` records provider versions and checksums.
This lab selected AWS 5.52.0 and Random 3.6.3. A normal `terraform init` reuses
the locked versions when they satisfy the constraints. To deliberately
reselect providers, use `terraform init -upgrade`, review the lock file diff,
then validate the configuration and review a fresh plan before applying.

```bash
terraform version
terraform init -lockfile=readonly
terraform validate
terraform plan -out=version-update.tfplan
```

Create a fresh plan after changing the CLI or providers. Keep state, saved
plans, local variables, and provider downloads outside Git. Before changing
versions on an existing deployment, check the upgrade guidance and protect
the state. An older Terraform release may be unable to read state written by
a newer release.

## HCP Terraform workspaces

For remote execution, check the Terraform version selected for the workspace
against the configuration's `required_version` before starting a run. The
workspace version report uses the HCP Terraform API and requires `curl`,
`jq`, and a token with workspace read access. Supply the token through
`TFC_TOKEN` in your shell environment, then run
`bash workspace_versions.sh <organization>`. Keep the token in your secret
store or enter it through a hidden prompt. Keep it out of Git and shell
history. This configuration has no HCP workspace binding.

[Terraform version constraints](https://developer.hashicorp.com/terraform/language/expressions/version-constraints) ·
[Provider lock file](https://developer.hashicorp.com/terraform/language/files/dependency-lock) ·
[HCP Terraform workspace versions](https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-versions)

# Course work and redaction notes

This is a sanitized snapshot of the HashiCorp Create a Terraform Plan tutorial work. Original tutorial attribution and license are retained.

Includes configuration, dependency lock file, sanitized tutorial variable values, saved HCP plan references, and JSON plan exports. The plan references are documentation only and cannot be used to apply runs after redaction.

AWS account identifiers, organisation name, HCP run IDs, private/public IPs, hostnames, infrastructure resource IDs, and secret input values have been redacted where present. Canonical public AMI owner identifiers and AMI IDs are retained. Redactions make this an evidence snapshot; substitute your own settings to run it.

Generated .terraform provider binaries and downloaded module caches, and the original .git history, are omitted as tooling metadata. No source files containing AWS credentials are published. Credential detection includes AWS access key identifiers and explicit secret/session credential assignments.

## Configuration observation

The current main.tf contains `some_key = "var.secret_key"`. This is a literal string. The intended tutorial expression is `some_key = var.secret_key`. The snapshot preserves the original expression to accurately document the work; the plan exports may reflect different stages of the tutorial.

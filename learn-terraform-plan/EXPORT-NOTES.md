# Course work and redaction notes

This is a sanitized snapshot of the HashiCorp Create a Terraform Plan tutorial work. Original tutorial attribution and license are retained.

The snapshot includes the configuration and dependency lock file. Supply your
own workspace settings and inputs before running the lesson. Local variable
files, plan files, JSON plan exports, state, and provider caches are kept out
of the current snapshot. Earlier commits contained redacted plan evidence.

## Configuration observation

The current main.tf contains `some_key = "var.secret_key"`. This is a literal string. The intended tutorial expression is `some_key = var.secret_key`. The snapshot preserves the original expression to accurately document the work; the historical exports may reflect different stages of the tutorial.

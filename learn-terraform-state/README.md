# Learn Terraform State Management

This repo is a companion repo to the [Learn Terraform State Management](https://developer.hashicorp.com/terraform/tutorials/state/state-cli) tutorial.
It contains Terraform configuration you can use to learn how to create an AWS instance and security group, examine a state file, and then manipulate resources to observe how vital state is to your Terraform operations.

## What I covered

- Used an EC2 instance and a security group to explore Terraform's state.
- Kept a second configuration in new_state with its own local state.
- Used terraform_remote_state to read the root security group output from
  ../terraform.tfstate.
- Reviewed instance replacement and the effects of changing state ownership.
- Recorded a removed block with destroy = false for the old instance address.

The root and new_state directories are separate root modules. Their relative
layout matters because new_state reads the parent state path. State files,
backups, provider caches, and saved execution plans are kept local.

## Plan evidence

| Report | Proposed actions |
| --- | --- |
| [Initial](../plan-reports/state-initial.json) | Create one EC2 instance and one security group |
| [Follow-up](../plan-reports/state-followup.json) | Two managed resources unchanged |
| [Replacement](../plan-reports/state-replacement.json) | Replace the EC2 instance; security group unchanged |
| [Second configuration](../plan-reports/state-new-instance.json) | Create an EC2 instance |
| [After move](../plan-reports/state-after-move.json) | Delete one EC2 instance; two resources unchanged |
| [Before removal](../plan-reports/state-pre-remove.json) | Delete one EC2 instance; two resources unchanged |

The last two saved plans contain a deletion proposal. The current removed block
records a later configuration intended to forget the old address without
destroying its object. The reports preserve the saved plans as they were,
rather than describing them as plans of the final source. The available saved
plan evidence does not establish that the removal block was applied.

## Reproducing the exercise

Use an isolated lab and generate fresh state. Initialise and validate each root
module separately. new_state requires the parent state to expose security_group
before its remote-state read can succeed. Review ownership carefully when
moving an object between states to avoid two configurations managing it.

The exercise opens TCP 8080 to the internet and uses an older Ubuntu AMI lookup
from the tutorial. Review those lab choices before deploying it. Access to a
state snapshot can expose more data than its declared outputs.

[State management tutorial](https://developer.hashicorp.com/terraform/tutorials/state/state-cli) ·
[Removed blocks](https://developer.hashicorp.com/terraform/language/block/removed) ·
[Remote state data](https://developer.hashicorp.com/terraform/language/state/remote-state-data)

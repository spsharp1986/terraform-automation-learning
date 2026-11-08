#!/bin/bash
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0
set -euo pipefail

# Report HCP Terraform workspace versions. Provide a read-scoped token via TFC_TOKEN.
if [[ $# != 1 || ! ${1:-} =~ ^[a-zA-Z0-9_-]+$ || -z ${TFC_TOKEN:-} ]]; then
    echo "Usage: set TFC_TOKEN in the environment, then run $0 <organization>" >&2
    exit 1
fi

organization=$1
page=1
while [[ $page != null ]]; do
    response=$(printf 'Authorization: Bearer %s\n' "$TFC_TOKEN" |
        curl --silent --show-error --fail --get --header @- \
            --data-urlencode "page[number]=$page" \
            "https://app.terraform.io/api/v2/organizations/$organization/workspaces")
    jq '.data[] | {workspace: .attributes.name, "terraform-version": .attributes["terraform-version"]}' <<< "$response"
    page=$(jq -r '.meta.pagination["next-page"]' <<< "$response")
done

#!/usr/bin/env bash

set -euo pipefail

cp /.github/stale.yml .github/stale.yml
cp /.github/workflows/boto.yml .github/workflows
# dhall-yaml /workflows/github-actions-dhall.dhall

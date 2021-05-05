#!/usr/bin/env bash

set -euo pipefail

cp /workflows/boto.yml .github/workflows
dhall-yaml /workflows/github-actions-dhall.dhall

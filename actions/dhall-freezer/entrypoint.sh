#!/usr/bin/env bash

set -euo pipefail

# Inspired by https://github.com/awseward/gh-actions-dhall/blob/b35c441389b100240e2027fa587740245911f152/bin/_freeze

find . -type f -name '*.dhall' | sort -u | while read -r fpath; do
  echo "${fpath}" | xargs -t dhall freeze --inplace
done

git diff --color=always --exit-code

#!/usr/bin/env bash

set -euo pipefail

find . -type f -name '*.dhall' | sort -u | while read -r fpath; do
  echo "${fpath}" | xargs -t dhall freeze --inplace
done

git diff --color=always --exit-code

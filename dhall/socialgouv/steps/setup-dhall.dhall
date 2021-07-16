let GithubActions =
      ../../github-actions/package.dhall sha256:61e7d862f54e9514379feaadbc80a85b7bd870dad5e31e2e83d8b3dd9eda8e1b

let step =
      GithubActions.Step::{
      , name = Some "Step Dhall"
      , uses = Some
          "dhall-lang/setup-dhall@35fa9f606036a9b7138bcbc4d519021fdda7bd5e"
      , `with` = Some
          (toMap { github_token = "\${{ github.token }}", version = "1.38.1" })
      }

in  step

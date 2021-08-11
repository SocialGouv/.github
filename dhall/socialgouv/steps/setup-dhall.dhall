let GithubActions =
      ../../github-actions/package.dhall sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let step =
      GithubActions.Step::{
      , name = Some "Step Dhall"
      , uses = Some
          "dhall-lang/setup-dhall@35fa9f606036a9b7138bcbc4d519021fdda7bd5e"
      , `with` = Some
          (toMap { github_token = "\${{ github.token }}", version = "1.38.1" })
      }

in  step

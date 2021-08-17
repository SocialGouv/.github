let GithubActions =
      ../../github-actions/package.dhall
        sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let {- renovate(github-action): depName=dhall-lang/setup-dhall currentValue=v4 -}
    v4 =
      "35fa9f606036a9b7138bcbc4d519021fdda7bd5e"

let {- renovate: datasource=gitlab-tags depName=dhall-lang/dhall-haskell -}
    DHALL_VERSION =
      "1.39.0"

let step =
      GithubActions.Step::{
      , name = Some "Step Dhall"
      , uses = Some "dhall-lang/setup-dhall@${v4}"
      , `with` = Some
          ( toMap
              { github_token = "\${{ github.token }}", version = DHALL_VERSION }
          )
      }

in  step

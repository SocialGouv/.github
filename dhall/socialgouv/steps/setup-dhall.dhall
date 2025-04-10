let GithubActions =
      ../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

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

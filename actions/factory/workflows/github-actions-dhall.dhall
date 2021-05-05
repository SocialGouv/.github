let GithubActions = ../../github-actions/package.dhall

let name = "Github Actions Dhall"

let on =
      GithubActions.On::{
      , push = Some GithubActions.Push::{
        , branches = Some [ "master", "main" ]
        , paths = Some [ ".github/workflows/github-actions-dhall.yaml" ]
        }
      }

let runs-on = GithubActions.RunsOn.Type.ubuntu-latest

let checkout =
          GithubActions.steps.actions/checkout
      //  GithubActions.Step::{
          , name = Some "Checkout"
          , `with` = Some
              ( toMap
                  { branch = "\${{ steps.comment.outputs.branch }}"
                  , token = "\${{ secrets.SOCIALGROOVYBOT_BOTO_PAT }}"
                  }
              )
          }

let dhall_version = "1.38.1"

let setup-dhall =
      GithubActions.Step::{
      , name = Some "Step Dhall"
      , uses = Some
          "dhall-lang/setup-dhall@35fa9f606036a9b7138bcbc4d519021fdda7bd5e"
      , `with` = Some
          ( toMap
              { github_token = "\${{ github.token }}", version = dhall_version }
          )
      }

let lint =
      GithubActions.Job::{
      , name = Some "Lint"
      , runs-on
      , steps =
        [ checkout
        , setup-dhall
        , GithubActions.Step::{
          , name = Some "Dhall Lint"
          , run = Some
              ''
              find * -name '*.dhall' -type f -print0 |
                sort -buz |
                xargs -0 -i -t dhall lint --inplace {} --check
              ''
          }
        ]
      }

let freezer =
      GithubActions.Job::{
      , name = Some "Freeze all .dhall files"
      , runs-on
      , steps =
        [ checkout
        , setup-dhall
        , GithubActions.Step::{
          , name = Some "Dhall Freeze"
          , run = Some
              ''
              find * -name '*.dhall' -type f -print0 |
                sort -buz |
                xargs -0 -i -t dhall freeze --inplace {}
              ''
          }
        ]
      }

let workflows_maker =
      GithubActions.Job::{
      , name = Some "Make the workflows"
      , needs = Some [ "lint", "freezer" ]
      , runs-on
      , steps =
        [ checkout
        , setup-dhall
        , GithubActions.Step::{
          , name = Some "Dhall Lint"
          , run = Some
              ''
              find dhall/.github/workflows-src -name '*.dhall' -type f -print0 |
                sort -buz |
                xargs -0 -i sh -xc '
                  dhall-to-yaml --file {} --output .github/workflows/$(basename {} .dhall).yaml
              ''
          }
        ]
      }

in  GithubActions.Workflow::{ name, on, jobs = toMap { lint } }

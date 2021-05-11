let GithubActions =
      ../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let setup-dhall = ../steps/setup-dhall.dhall

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
      //  { name = Some "Checkout"
          , `with` = Some
              ( toMap
                  { branch = "\${{ steps.comment.outputs.branch }}"
                  , token = "\${{ secrets.SOCIALGROOVYBOT_BOTO_PAT }}"
                  }
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

in  GithubActions.Workflow::{ name, on, jobs = toMap { lint } }

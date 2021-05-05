let GithubActions =
      ../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let add-and-commit = ../steps/add-and-commit.dhall

let dhall-lang/setup-dhall = ../../steps/dhall-lang/setup-dhall/package.dhall

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
      ⫽ GithubActions.Step::{
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
      dhall-lang/setup-dhall.`v4.2.0`
        dhall-lang/setup-dhall.Input::{ version = Some dhall_version }

let lint =
      GithubActions.Job::{
      , name = Some "Lint all .dhall files"
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
        , add-and-commit
            { message = "chore(:robot:): workflows-src to workflows"
            , add = ".github/workflows/"
            }
        ]
      }

in  GithubActions.Workflow::{ name, on, jobs = toMap { lint, freezer } }

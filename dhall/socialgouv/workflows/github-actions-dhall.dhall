let GithubActions =
      ../../github-actions/package.dhall sha256:2bbfa9dca70fcfb23b1382e737768a6447d766bcc4b8f2ef1141dd6b94cc5fee

let setup-dhall =
      ../steps/setup-dhall.dhall sha256:17d25b4ca228028938a58ba2bb0a668fdd2c9eb5d4b7ab377dac09aba655ed18

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

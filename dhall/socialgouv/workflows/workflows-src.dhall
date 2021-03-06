let GithubActions =
      ../../github-actions/package.dhall sha256:61e7d862f54e9514379feaadbc80a85b7bd870dad5e31e2e83d8b3dd9eda8e1b

let add-and-commit =
      ../steps/add-and-commit.dhall sha256:15423ba92afda80694de97e1d3100da031180434e1fa546b3aa23d426bb36786

let dhall-lang/setup-dhall =
      ../../steps/dhall-lang/setup-dhall/package.dhall sha256:2bcd97c0d170aecede86ef3294018eb0f36a87a41d0503ec950ce7112967f8b0

let name = "🤖 / Dhall Workflows"

let on =
      GithubActions.On::{
      , push = Some GithubActions.Push::{
        , branches = Some [ "master", "main" ]
        , paths = Some
          [ ".github/workflows-src/**"
          , ".github/workflows/@workflows-src.yaml"
          ]
        }
      , pull_request = Some GithubActions.Push::{
        , branches = Some [ "master", "main" ]
        , paths = Some
          [ ".github/workflows-src/**"
          , ".github/workflows/@workflows-src.yaml"
          ]
        }
      , workflow_dispatch = Some GithubActions.WorkflowDispatch::{=}
      }

let runs-on = GithubActions.RunsOn.Type.ubuntu-latest

let checkout =
        GithubActions.steps.actions/checkout
      ⫽ { name = Some "Checkout"
        , `with` = Some
            (toMap { token = "\${{ secrets.SOCIALGROOVYBOT_BOTO_PAT }}" })
        }

let dhall_version = "1.38.1"

let setup-dhall =
      dhall-lang/setup-dhall.`v4.2.0`
        dhall-lang/setup-dhall.Input::{ version = Some dhall_version }

let workflows-src-to-workflows =
      GithubActions.Job::{
      , name = Some "Convert to workflows"
      , runs-on
      , steps =
        [ checkout
        , setup-dhall
        , GithubActions.Step::{
          , name = Some "Github Actions Dhall To Yaml"
          , run = Some
              ''
              find .github/workflows-src -name '*.dhall' -type f -print0 |
                sort -buz |
                xargs -0 -i sh -xc '
                  dhall freeze --inplace {} &&
                  dhall lint --inplace {} &&
                  dhall-to-yaml --file {} --output .github/workflows/$(basename {} .dhall).yaml
                '
              ''
          }
        , add-and-commit
            { message = "chore(:robot:): workflows-src to workflows"
            , add = ".github/"
            }
        ]
      }

in  GithubActions.Workflow::{
    , name
    , on
    , jobs = toMap { workflows-src-to-workflows }
    }

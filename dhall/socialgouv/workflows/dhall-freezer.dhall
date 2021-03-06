let GithubActions =
      ../../github-actions/package.dhall sha256:61e7d862f54e9514379feaadbc80a85b7bd870dad5e31e2e83d8b3dd9eda8e1b

let add-and-commit =
      ../steps/add-and-commit.dhall sha256:15423ba92afda80694de97e1d3100da031180434e1fa546b3aa23d426bb36786

let dhall-lang/setup-dhall =
      ../../steps/dhall-lang/setup-dhall/package.dhall sha256:2bcd97c0d170aecede86ef3294018eb0f36a87a41d0503ec950ce7112967f8b0

let name = "Dhall freezer"

let on =
      λ(workflow_file : Text) →
      λ(cwd : Text) →
        GithubActions.On::{
        , push = Some GithubActions.Push::{
          , branches = Some [ "master", "main" ]
          , paths = Some [ workflow_file, "${cwd}/**" ]
          }
        , pull_request = Some GithubActions.Push::{
          , paths = Some [ workflow_file, "${cwd}/**" ]
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

let freeze =
      λ(cwd : Text) →
        GithubActions.Job::{
        , name = Some "Freeze"
        , runs-on
        , steps =
          [ checkout
          , setup-dhall
          , GithubActions.Step::{
            , name = Some "Dhall Freeze"
            , run = Some
                ''
                find ${cwd} -name '*.dhall' -type f -print0 |
                  sort -buz |
                  xargs -0 -i sh -xc '
                    dhall freeze --all --transitive {} &&
                    dhall lint --inplace {}
                  '
                ''
            }
          , add-and-commit
              { message = "chore(:robot:): dhall freezer", add = "${cwd}" }
          ]
        }

in  λ(workflow_file : Text) →
    λ(cwd : Text) →
      GithubActions.Workflow::{
      , name
      , on = on workflow_file cwd
      , jobs = toMap { freezer = freeze cwd }
      }

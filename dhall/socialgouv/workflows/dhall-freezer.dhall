let GithubActions =
      ../../github-actions/package.dhall
        sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let add-and-commit =
      ../steps/add-and-commit.dhall
        sha256:15423ba92afda80694de97e1d3100da031180434e1fa546b3aa23d426bb36786

let dhall-lang/setup-dhall =
      ../../steps/dhall-lang/setup-dhall/package.dhall
        sha256:2bcd97c0d170aecede86ef3294018eb0f36a87a41d0503ec950ce7112967f8b0

let name = "Dhall freezer"

let on =
      λ(workflow_file : Text) →
      λ(cwd : Text) →
        GithubActions.On::{
        , push = Some GithubActions.Push::{
          , branches = Some [ "master", "main" ]
          , paths = Some [ workflow_file, "${cwd}/**" ]
          }
        , pull_request = Some GithubActions.PullRequest::{
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

let dhall_version = "1.39.0"

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
                    dhall format {} &&
                    dhall lint {}
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

let GithubActions =
      ../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let name = "Dhall freezer"

let on =
      GithubActions.On::{
      , push = Some GithubActions.Push::{
        , branches = Some [ "master", "main" ]
        , paths = Some [ "**/*.dhall" ]
        }
      , pull_request = Some GithubActions.Push::{
        , paths = Some [ "**/*.dhall" ]
        }
      , workflow_dispatch = Some GithubActions.WorkflowDispatch::{=}
      }

let runs-on = GithubActions.RunsOn.Type.ubuntu-latest

let checkout =
      GithubActions.Step::{
      , name = Some "Checkout"
      , uses = Some "actions/checkout@5a4ac9002d0be2fb38bd78e4b4dbde5606d7042f"
      , `with` = Some
          ( toMap
              { ref = "\${{ steps.comment.outputs.branch }}"
              , token = "\${{ secrets.SOCIALGROOVYBOT_BOTO_PAT }}"
              }
          )
      }

let add-and-commit
    : ∀(args : { add : Text, message : Text }) → GithubActions.Step.Type
    = λ(args : { add : Text, message : Text }) →
        GithubActions.Step::{
        , name = Some "Commit changes"
        , uses = Some
            "EndBug/add-and-commit@a3adef035a1381dcf888c90b847240e2ddb9e008"
        , env = Some
            ( toMap
                { GITHUB_TOKEN = "\${{ secrets.SOCIALGROOVYBOT_BOTO_PAT }}" }
            )
        , `with` = Some
            ( toMap
                { author_email = "\${{ secrets.SOCIALGROOVYBOT_EMAIL }}"
                , author_name = "\${{ secrets.SOCIALGROOVYBOT_NAME }}"
                , branch = "\${{ steps.comment.outputs.branch }}"
                , message = args.message
                , add = args.add
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
            { message = "chore(:robot:): dhall freezer", add = "*.dhall" }
        ]
      }

in  GithubActions.Workflow::{ name, on, jobs = toMap { lint, freezer } }

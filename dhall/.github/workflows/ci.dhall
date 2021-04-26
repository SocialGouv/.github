let GithubActions =
      ../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let setup-dhall =
      ../../steps/dhall-lang/setup-dhall/package.dhall sha256:2bcd97c0d170aecede86ef3294018eb0f36a87a41d0503ec950ce7112967f8b0

in  GithubActions.Workflow::{
    , name = "Dhall"
    , on = GithubActions.On::{ push = Some GithubActions.Push::{=} }
    , jobs = toMap
        { ci = GithubActions.Job::{
          , name = Some "Quality"
          , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
          , steps =
            [ GithubActions.steps.actions/checkout
            , setup-dhall.`v4.2.0` setup-dhall.Input::{=}
            , GithubActions.Step::{ run = Some "make" }
            ]
          }
        }
    }

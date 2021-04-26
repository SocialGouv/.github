let GithubActions =
      https://raw.githubusercontent.com/regadas/github-actions-dhall/master/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let SocailGouvSteps = ../../socialgouv/steps.dhall

in  GithubActions.Workflow::{
    , name = "Dhall"
    , on = GithubActions.On::{ push = Some GithubActions.Push::{=} }
    , jobs = toMap
        { ci = GithubActions.Job::{
          , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
          , steps =
            [ GithubActions.steps.actions/checkout
            , SocailGouvSteps.dhall.`6.0.0-beta.3`
                ''
                  find . -type f -name '*.dhall' | sort -u | while read -r fpath; do
                    dhall lint "''${fpath}"
                  done
                ''
            ]
          }
        }
    }

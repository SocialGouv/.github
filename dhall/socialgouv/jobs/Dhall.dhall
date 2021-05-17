let GithubActions =
      ../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let setup-dhall =
      ../steps/setup-dhall.dhall sha256:17d25b4ca228028938a58ba2bb0a668fdd2c9eb5d4b7ab377dac09aba655ed18

let job =
      λ(args : { working-directory : Text, run : Text }) →
        GithubActions.Job::{
        , name = Some "Dhall Lint"
        , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
        , steps =
          [ GithubActions.steps.actions/checkout
          , setup-dhall
          , GithubActions.Step::{
            , name = Some "Dhall Lint"
            , run = Some
                ''
                find ${args.working-directory} -name '*.dhall' -type f -print0 |
                  sort -buz |
                  xargs -0 -i -t ${args.run}
                ''
            }
          ]
        }

let __test__foo =
        assert
      :   job
            { working-directory = "*", run = "dhall lint --inplace {} --check" }
        ≡ GithubActions.Job::{
          , name = Some "Dhall Lint"
          , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
          , steps =
            [ GithubActions.steps.actions/checkout
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

in  job

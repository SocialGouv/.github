let GithubActions =
      ../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

let setup-dhall =
      ../steps/setup-dhall.dhall
        sha256:eb2e365f0dd320c295ed255b0321a088287d0e971167b53e684203a2a4c32d0e

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

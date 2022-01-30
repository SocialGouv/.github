let GithubActions =
      ../../github-actions/package.dhall
        sha256:53da2310a2e009556455a73684b997c3bd53192637ac3c77562c30e3815f5f23

let setup-dhall =
      ../steps/setup-dhall.dhall
        sha256:ad5a9d2b9f097127714cb086d71c0464ce25d9aea09569ae14433963b8f7d245

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

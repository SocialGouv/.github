let GithubActions =
      ../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let Semantic =
      ../../github-actions/sementic.dhall sha256:80f8fba713446763d862fb20e1e6e6984bc2ef57f321cc1a67672fe073755820

let name = "Release"

let release =
      GithubActions.Job::{
      , name = Some "Release"
      , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
      , steps =
        [     GithubActions.steps.actions/checkout
          //  { name = Some "Checkout"
              , `with` = Some
                  (toMap { token = "\${{ secrets.SOCIALGROOVYBOT_BOTO_PAT }}" })
              }
        , GithubActions.Step::{
          , name = Some "Semantic Release"
          , uses = Some "cycjimmy/semantic-release-action@v2"
          , `with` = Some
              ( toMap
                  { extra_plugins =
                      ''
                        @semantic-release/changelog
                        @semantic-release/exec
                        @semantic-release/git
                      ''
                  }
              )
          , env = Some
              ( toMap
                  { GH_TOKEN = "\${{ secrets.GITHUB_TOKEN }}"
                  , GIT_AUTHOR_EMAIL = "\${{ secrets.SOCIALGROOVYBOT_EMAIL }}"
                  , GIT_AUTHOR_NAME = "\${{ secrets.SOCIALGROOVYBOT_NAME }}"
                  , GIT_COMMITTER_EMAIL =
                      "\${{ secrets.SOCIALGROOVYBOT_EMAIL }}"
                  , GIT_COMMITTER_NAME = "\${{ secrets.SOCIALGROOVYBOT_NAME }}"
                  , GITHUB_TOKEN = "\${{ secrets.GITHUB_TOKEN }}"
                  }
              )
          }
        ]
      }

in  GithubActions.Workflow::{
    , name
    , on = Semantic.OnReleaseBranches
    , jobs = toMap { release }
    }

let GithubActions =
      ../../github-actions/package.dhall sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let Semantic =
      ../../github-actions/sementic.dhall sha256:94d6f3731a37b255d45f39823045d89b9b1ebe0c4ad3d00462240856eed806b0

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

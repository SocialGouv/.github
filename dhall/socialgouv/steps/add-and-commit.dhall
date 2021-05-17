let GithubActions =
      ../../github-actions/package.dhall sha256:2bbfa9dca70fcfb23b1382e737768a6447d766bcc4b8f2ef1141dd6b94cc5fee

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

let __test__foo =
        assert
      :   add-and-commit { message = "chore(:robot:): foo bar", add = "stuff" }
        ≡ GithubActions.Step::{
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
                  , message = "chore(:robot:): foo bar"
                  , add = "stuff"
                  }
              )
          }

in  add-and-commit

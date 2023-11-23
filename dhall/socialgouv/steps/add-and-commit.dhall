let GithubActions =
      ../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

let {- renovate(github-action): depName=EndBug/add-and-commit currentValue=v7 -}
    v7 =
      "8c12ff729a98cfbcd3fe38b49f55eceb98a5ec02"

let add-and-commit
    : ∀(args : { add : Text, message : Text }) → GithubActions.Step.Type
    = λ(args : { add : Text, message : Text }) →
        GithubActions.Step::{
        , name = Some "Commit changes"
        , uses = Some "EndBug/add-and-commit@${v7}"
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
          , uses = Some "EndBug/add-and-commit@${v7}"
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

let GithubActions =
      ../../../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let Input =
      ./Input.dhall sha256:745813296592817710ae7a0c62617b726bd0f38cc8f4f46e1714f7705a6eb19a

let utils =
      ../../../utils.dhall sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

let step
    : ∀(ref : Text) → ∀(opts : Input.Type) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(opts : Input.Type) →
        GithubActions.Step::{
        , uses = Some "dhall-lang/setup-dhall@${ref}"
        , `with` = Some (utils.unpackTextOptions (toMap opts))
        }

let __test__minimal =
        assert
      :   step "vX.Y.Z" Input::{=}
        ≡ GithubActions.Step::{
          , uses = Some "dhall-lang/setup-dhall@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let __test__tags_options =
        assert
      :   step
            "vX.Y.Z"
            Input::{
            , github_token = Some "\${{ github.token }}"
            , version = Some "vX.Y.Z"
            }
        ≡ GithubActions.Step::{
          , uses = Some "dhall-lang/setup-dhall@vX.Y.Z"
          , `with` = Some
            [ { mapKey = "github_token", mapValue = "\${{ github.token }}" }
            , { mapKey = "version", mapValue = "vX.Y.Z" }
            ]
          }

let __test__step_id =
        assert
      :   step "vX.Y.Z" Input::{=} ⫽ { id = Some "dhall" }
        ≡ GithubActions.Step::{
          , id = Some "dhall"
          , uses = Some "dhall-lang/setup-dhall@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let `v4.2.0` =
    {-
    This dhall is mapping a fixed version of the dhall-lang/setup-dhall
    https://github.com/dhall-lang/setup-dhall/tree/v4.2.0
    commit/35fa9f606036a9b7138bcbc4d519021fdda7bd5e
    -}
      "35fa9f606036a9b7138bcbc4d519021fdda7bd5e"

in  { `v4.2.0` = step `v4.2.0`, step }

let GithubActions =
      ../../../github-actions/package.dhall
        sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let Input =
      ./Input.dhall
        sha256:9d8fdd35987ff892001969ca54a9bbeb6b32a91d1124a753f5efc8cd5ca159eb

let utils =
      ../../utils.dhall
        sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

let step
    : ∀(ref : Text) → ∀(opts : Input.Type) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(opts : Input.Type) →
        GithubActions.Step::{
        , uses = Some "docker/build-push-action@${ref}"
        , `with` = Some (utils.unpackTextOptions (toMap opts))
        }

let __test__minimal =
        assert
      :   step "vX.Y.Z" Input::{=}
        ≡ GithubActions.Step::{
          , uses = Some "docker/build-push-action@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let __test__ghcr_io =
        assert
      :   step "vX.Y.Z" Input::{ push = Some "true" }
        ≡ GithubActions.Step::{
          , uses = Some "docker/build-push-action@vX.Y.Z"
          , `with` = Some [ { mapKey = "push", mapValue = "true" } ]
          }

let __test__step_id =
        assert
      :   step "vX.Y.Z" Input::{=} ⫽ { id = Some "build" }
        ≡ GithubActions.Step::{
          , id = Some "build"
          , uses = Some "docker/build-push-action@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let {- renovate(github-action): depName=docker/build-push-action currentValue=v5 -}
    v5 =
      "ca052bb54ab0790a636c9b5f226502c73d547a25"

in  { v2 = step v2, v2/sha = v2, step }

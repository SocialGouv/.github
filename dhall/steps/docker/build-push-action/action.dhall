let GithubActions =
      ../../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let Input =
      ./Input.dhall sha256:9d8fdd35987ff892001969ca54a9bbeb6b32a91d1124a753f5efc8cd5ca159eb

let utils =
      ../../utils.dhall sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

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

let `v2.4.0` =
    {-
    This dhall is mapping a fixed version of the docker/build-push-action
    https://github.com/docker/build-push-action/tree/v2.4.0
    commit/e1b7f96249f2e4c8e4ac1519b9608c0d48944a1f
    -}
      "e1b7f96249f2e4c8e4ac1519b9608c0d48944a1f"

in  { `v2.4.0` = step `v2.4.0`, step }

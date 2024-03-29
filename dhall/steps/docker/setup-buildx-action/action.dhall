let GithubActions =
      ../../../github-actions/package.dhall
        sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let Input =
      ./Input.dhall
        sha256:dc5902ae5261dcd968d3cd025c90001c50d2fbc2413dda62c4fd29b588be4db8

let utils =
      ../../utils.dhall
        sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

let step
    : ∀(ref : Text) → ∀(opts : Input.Type) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(opts : Input.Type) →
        GithubActions.Step::{
        , uses = Some "docker/setup-buildx-action@${ref}"
        , `with` = Some (utils.unpackTextOptions (toMap opts))
        }

let __test__minimal =
        assert
      :   step "vX.Y.Z" Input::{=}
        ≡ GithubActions.Step::{
          , uses = Some "docker/setup-buildx-action@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let __test__tags_options =
        assert
      :   step "vX.Y.Z" Input::{ install = Some "false" }
        ≡ GithubActions.Step::{
          , uses = Some "docker/setup-buildx-action@vX.Y.Z"
          , `with` = Some (toMap { install = "false" })
          }

let __test__step_id =
        assert
      :   step "vX.Y.Z" Input::{=} ⫽ { id = Some "buildx" }
        ≡ GithubActions.Step::{
          , id = Some "buildx"
          , uses = Some "docker/setup-buildx-action@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let {- renovate(github-action): depName=docker/setup-buildx-action currentValue=v1 -}
    v1 =
      "abe5d8f79a1606a2d3e218847032f3f2b1726ab0"

in  { v1 = step v1, v1/sha = v1, step }

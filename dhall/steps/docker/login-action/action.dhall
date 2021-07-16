let GithubActions =
      ../../../github-actions/package.dhall sha256:61e7d862f54e9514379feaadbc80a85b7bd870dad5e31e2e83d8b3dd9eda8e1b

let Input =
      ./Input.dhall sha256:0d8417e4fb8839b85192c94b4c36177c874abbacda9e59f8457d87a9095e27d3

let utils =
      ../../utils.dhall sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

let step
    : ∀(ref : Text) → ∀(opts : Input.Type) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(opts : Input.Type) →
        GithubActions.Step::{
        , uses = Some "docker/login-action@${ref}"
        , `with` = Some (utils.unpackTextOptions (toMap opts))
        }

let __test__minimal =
        assert
      :   step "vX.Y.Z" Input::{=}
        ≡ GithubActions.Step::{
          , uses = Some "docker/login-action@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let __test__ghcr_io =
        assert
      :   step
            "vX.Y.Z"
            Input::{
            , password = Some "\${{ secrets.CR_PAT }}"
            , registry = Some "ghcr.io"
            , username = Some "\${{ github.repository_owner }}"
            }
        ≡ GithubActions.Step::{
          , uses = Some "docker/login-action@vX.Y.Z"
          , `with` = Some
            [ { mapKey = "password", mapValue = "\${{ secrets.CR_PAT }}" }
            , { mapKey = "registry", mapValue = "ghcr.io" }
            , { mapKey = "username"
              , mapValue = "\${{ github.repository_owner }}"
              }
            ]
          }

let __test__step_id =
        assert
      :   step "vX.Y.Z" Input::{=} ⫽ { id = Some "login" }
        ≡ GithubActions.Step::{
          , id = Some "login"
          , uses = Some "docker/login-action@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let `v1.8.0` =
    {-
    This dhall is mapping a fixed version of the docker/login-action
    https://github.com/docker/login-action/tree/v1.8.0
    commit/f3364599c6aa293cdc2b8391b1b56d0c30e45c8a
    -}
      "f3364599c6aa293cdc2b8391b1b56d0c30e45c8a"

in  { `v1.8.0` = step `v1.8.0`, step }

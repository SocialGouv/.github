let GithubActions =
      ../../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

let Input =
      ./Input.dhall
        sha256:0d8417e4fb8839b85192c94b4c36177c874abbacda9e59f8457d87a9095e27d3

let utils =
      ../../utils.dhall
        sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

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

let {- renovate(github-action): depName=docker/login-action currentValue=v1 -}
    v1 =
      "f054a8b539a109f9f41c372932f1ae047eff08c9"

in  { v1 = step v1, v1/sha = v1, step }

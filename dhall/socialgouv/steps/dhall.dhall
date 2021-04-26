let GithubActions =
      ../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let socialgouv/dhall
    : ∀(ref : Text) → ∀(args : Text) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(args : Text) →
        GithubActions.Step::{
        , name = Some args
        , uses = Some "docker://ghcr.io/socialgouv/docker/dhall:${ref}"
        , `with` = Some (toMap { args })
        }

let __test__foo =
        assert
      :   socialgouv/dhall "vX.Y.Z" "dhall freeze --inplace"
        ≡ GithubActions.Step::{
          , name = Some "dhall freeze --inplace"
          , uses = Some "docker://ghcr.io/socialgouv/docker/dhall:vX.Y.Z"
          , `with` = Some
            [ { mapKey = "args", mapValue = "dhall freeze --inplace" } ]
          }

let `6.0.0-beta.3` =
    {-
    This dhall is mapping a fixed version of the SocialGouv/docker/
    https://github.com/orgs/SocialGouv/packages/container/docker%2Fdhall
    commit/905249e2e9095d77c20ce078739cabdb6c2a55b1
    -}
      "6.0.0-beta.3@sha256:8c995787303a6d8c9c38d2abe1122e25ddd3b7e26111fc421cc0bd881679efb4"

in  { `6.0.0-beta.3` = socialgouv/dhall `6.0.0-beta.3`
    , step = socialgouv/dhall
    }

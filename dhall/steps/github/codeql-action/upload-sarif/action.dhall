let GithubActions =
      ../../../../github-actions/package.dhall
        sha256:0fab6df1dd1ec6e6d048d19951a5b7d195c3eb14723e24c25b7a40ff1433a02b

let Input =
      ./Input.dhall
        sha256:112bba6b5f9dd0e0aea65d7d1b69bb7ce440ad7e95fcb339d3a9baa52e1b2b6c

let utils =
      ../../../utils.dhall
        sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

let step
    : ∀(ref : Text) → ∀(opts : Input.Type) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(opts : Input.Type) →
        GithubActions.Step::{
        , uses = Some "github/codeql-action/upload-sarif@${ref}"
        , `with` = Some (utils.unpackTextOptions (toMap opts))
        }

let __test__minimal =
        assert
      :   step "vX.Y.Z" Input::{=}
        ≡ GithubActions.Step::{
          , uses = Some "github/codeql-action/upload-sarif@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let __test__tags_options =
        assert
      :   step "vX.Y.Z" Input::{ sarif_file = Some "trivy-results.sarif" }
        ≡ GithubActions.Step::{
          , uses = Some "github/codeql-action/upload-sarif@vX.Y.Z"
          , `with` = Some
            [ { mapKey = "sarif_file", mapValue = "trivy-results.sarif" } ]
          }

let __test__step_id =
        assert
      :   step "vX.Y.Z" Input::{=} ⫽ { id = Some "dhall" }
        ≡ GithubActions.Step::{
          , id = Some "dhall"
          , uses = Some "github/codeql-action/upload-sarif@vX.Y.Z"
          , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
          }

let codeql-bundle-20210421 =
    {-
        This dhall is mapping a fixed version of the github/codeql-action/upload-sarif
    https://github.com/github/codeql-action/tree/codeql-bundle-20210421/upload-sarif
    commit/a3a8231e64d3db0e7da0f3b56b9521dcccdfe412
        -}
      "a3a8231e64d3db0e7da0f3b56b9521dcccdfe412"

in  { codeql-bundle-20210421 = step codeql-bundle-20210421, step }

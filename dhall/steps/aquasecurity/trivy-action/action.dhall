let GithubActions =
      ../../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let Input =
      ./Input.dhall sha256:7a1d0cd9d9be38b5c0034538563fc6abf357229ea4c743d836ce76c0d78319dd

let utils = ../../utils.dhall

let step
    : ∀(ref : Text) → ∀(opts : Input.Type) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(opts : Input.Type) →
        GithubActions.Step::{
        , uses = Some "aquasecurity/trivy-action@${ref}"
        , `with` = Some
            ( utils.withInputs
                (toMap opts.{ image-ref })
                (toMap (opts ⫽ { image-ref = None Text }))
            )
        }

let __test__minimal =
        assert
      :   step
            "vX.Y.Z"
            Input::{
            , image-ref = "docker.io/my-organization/my-app:\${{ github.sha }}"
            }
        ≡ GithubActions.Step::{
          , uses = Some "aquasecurity/trivy-action@vX.Y.Z"
          , `with` = Some
            [ { mapKey = "image-ref"
              , mapValue = "docker.io/my-organization/my-app:\${{ github.sha }}"
              }
            ]
          }

let __test__sarif =
        assert
      :   step
            "vX.Y.Z"
            Input::{
            , format = Some "template"
            , image-ref = "docker.io/my-organization/my-app:\${{ github.sha }}"
            , output = Some "trivy-results.sarif"
            , template = Some "@/contrib/sarif.tpl"
            }
        ≡ GithubActions.Step::{
          , uses = Some "aquasecurity/trivy-action@vX.Y.Z"
          , `with` = Some
            [ { mapKey = "format", mapValue = "template" }
            , { mapKey = "output", mapValue = "trivy-results.sarif" }
            , { mapKey = "template", mapValue = "@/contrib/sarif.tpl" }
            , { mapKey = "image-ref"
              , mapValue = "docker.io/my-organization/my-app:\${{ github.sha }}"
              }
            ]
          }

let __test__step_id =
        assert
      :     step
              "vX.Y.Z"
              Input::{
              , image-ref =
                  "docker.io/my-organization/my-app:\${{ github.sha }}"
              }
          ⫽ { id = Some "Run Trivy vulnerability scanner" }
        ≡ GithubActions.Step::{
          , id = Some "Run Trivy vulnerability scanner"
          , uses = Some "aquasecurity/trivy-action@vX.Y.Z"
          , `with` = Some
            [ { mapKey = "image-ref"
              , mapValue = "docker.io/my-organization/my-app:\${{ github.sha }}"
              }
            ]
          }

let `0.0.17` =
    {-
    This dhall is mapping a fixed version of the aquasecurity/trivy-action
    https://github.com/aquasecurity/trivy-action/tree/0.0.17
    commit/dba83feec810c70bacbc4bead308ae1e466c572b
    -}
      "dba83feec810c70bacbc4bead308ae1e466c572b"

in  { `0.0.17` = step `0.0.17`, step }

let GithubActions =
      ../../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

let Input =
      ./Input.dhall
        sha256:7a1d0cd9d9be38b5c0034538563fc6abf357229ea4c743d836ce76c0d78319dd

let utils =
      ../../utils.dhall
        sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

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

let GithubActions =
      ../../../github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let Input =
      ./Input.dhall sha256:404042a94af2e74f1ac166cc9c5193c6a92360adc5a08ea01dcb164b9fb7dd10

let utils =
      ../../utils.dhall sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

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

let `0.0.14` =
    {-
    This dhall is mapping a fixed version of the aquasecurity/trivy-action
    https://github.com/aquasecurity/trivy-action/tree/0.0.14
    commit/b38389f8efef9798810fe0c5b5096ac198cffd54
    -}
      "b38389f8efef9798810fe0c5b5096ac198cffd54"

in  { `0.0.14` = step `0.0.14`, step }

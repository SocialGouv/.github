let GithubActions = ../../../github-actions/package.dhall

let Input = ./Input.dhall

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

let `0.0.14` =
    {-
    This dhall is mapping a fixed version of the aquasecurity/trivy-action
    https://github.com/aquasecurity/trivy-action/tree/0.0.14
    commit/b38389f8efef9798810fe0c5b5096ac198cffd54
    -}
      "b38389f8efef9798810fe0c5b5096ac198cffd54"

in  { `0.0.14` = step `0.0.14`, step }

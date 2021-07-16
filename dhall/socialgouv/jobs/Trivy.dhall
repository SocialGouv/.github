let GithubActions =
      ../../github-actions/package.dhall sha256:61e7d862f54e9514379feaadbc80a85b7bd870dad5e31e2e83d8b3dd9eda8e1b

let trivy-action =
      ../../steps/aquasecurity/trivy-action/package.dhall sha256:aeeb75c894a6a7c51d0c83574310e58db4d11698cbe9b5f443beb3043931474d

let upload-sarif =
      ../../steps/github/codeql-action/upload-sarif/package.dhall sha256:e96a4a49e32c41420b99afd427f0549038b2b33d399ec1a66295e19e6cd9bf1a

let Input = trivy-action.Input

let job =
      λ(input : trivy-action.Input.Type) →
        GithubActions.Job::{
        , name = Some "Vulnerability Scanner"
        , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
        , steps =
          [ GithubActions.steps.actions/checkout
          , GithubActions.Step::{ run = Some "docker pull ${input.image-ref}" }
          ,   trivy-action.`0.0.17`
                trivy-action.Input::{ image-ref = input.image-ref }
            ⫽ { name = Some "Run Trivy vulnerability scanner" }
          ,   trivy-action.`0.0.17`
                (   input
                  ⫽ { format = Some "template"
                    , template = Some "@/contrib/sarif.tpl"
                    , output = Some "trivy-results.sarif"
                    }
                )
            ⫽ { name = Some "Export Trivy Results as sarif" }
          , upload-sarif.codeql-bundle-20210421
              upload-sarif.Input::{ sarif_file = Some "trivy-results.sarif" }
          ]
        }

let __test__foo =
        assert
      :   job
            Input::{
            , image-ref =
                "ghcr.io/\${{ github.repository }}/foo:sha-\${{ github.sha }}"
            }
        ≡ GithubActions.Job::{
          , name = Some "Vulnerability Scanner"
          , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
          , steps =
            [ GithubActions.steps.actions/checkout
            , GithubActions.Step::{
              , run = Some
                  "docker pull ghcr.io/\${{ github.repository }}/foo:sha-\${{ github.sha }}"
              }
            ,   trivy-action.`0.0.17`
                  trivy-action.Input::{
                  , image-ref =
                      "ghcr.io/\${{ github.repository }}/foo:sha-\${{ github.sha }}"
                  }
              ⫽ { name = Some "Run Trivy vulnerability scanner" }
            ,   trivy-action.`0.0.17`
                  trivy-action.Input::{
                  , format = Some "template"
                  , image-ref =
                      "ghcr.io/\${{ github.repository }}/foo:sha-\${{ github.sha }}"
                  , template = Some "@/contrib/sarif.tpl"
                  , output = Some "trivy-results.sarif"
                  }
              ⫽ { name = Some "Export Trivy Results as sarif" }
            , upload-sarif.codeql-bundle-20210421
                upload-sarif.Input::{ sarif_file = Some "trivy-results.sarif" }
            ]
          }

in  { job, Input }

let GithubActions =
      ../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

let trivy-action =
      ../../steps/aquasecurity/trivy-action/package.dhall
        sha256:4fb339c675e5d814e08169b9d6a89318576fef69737f9bda63e8c451fc2de8b9

let upload-sarif =
      ../../steps/github/codeql-action/upload-sarif/package.dhall
        sha256:dd45ac7a4b1623f328d509ffd51eda2fea0d1bec965beb93e094e4a362940c7e

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

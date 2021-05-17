let GithubActions =
      https://raw.githubusercontent.com/SocialGouv/.github/master/dhall/github-actions/package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

let trivy-action =
      https://raw.githubusercontent.com/SocialGouv/.github/master/dhall/steps/aquasecurity/trivy-action/package.dhall sha256:72a518acac9663695cd99b5219b2f6d330ab32c1077c20bbd7804d8798485416

let upload-sarif =
      https://raw.githubusercontent.com/SocialGouv/.github/master/dhall/steps/github/codeql-action/upload-sarif/package.dhall sha256:e96a4a49e32c41420b99afd427f0549038b2b33d399ec1a66295e19e6cd9bf1a

let Input = trivy-action.Input

let job =
      λ(input : trivy-action.Input.Type) →
        GithubActions.Job::{
        , name = Some "Vulnerability Scanner"
        , runs-on = GithubActions.RunsOn.Type.ubuntu-latest
        , steps =
          [ GithubActions.steps.actions/checkout
          , GithubActions.Step::{ run = Some "docker pull ${input.image-ref}" }
          ,   trivy-action.`0.0.14`
                trivy-action.Input::{ image-ref = input.image-ref }
            ⫽ { name = Some "Run Trivy vulnerability scanner" }
          ,   trivy-action.`0.0.14`
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
            ,   trivy-action.`0.0.14`
                  trivy-action.Input::{
                  , image-ref =
                      "ghcr.io/\${{ github.repository }}/foo:sha-\${{ github.sha }}"
                  }
              ⫽ { name = Some "Run Trivy vulnerability scanner" }
            ,   trivy-action.`0.0.14`
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

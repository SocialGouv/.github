let GithubActions =
      ../../github-actions/package.dhall sha256:61e7d862f54e9514379feaadbc80a85b7bd870dad5e31e2e83d8b3dd9eda8e1b

let socialgouv/container-structure-test
    : ∀(ref : Text) → ∀(args : Text) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(args : Text) →
        GithubActions.Step::{
        , name = Some "Container structure test"
        , uses = Some
            "docker://gcr.io/gcp-runtimes/container-structure-test:${ref}"
        , `with` = Some (toMap { args = "test ${args}" })
        }

let __test__foo =
        assert
      :   socialgouv/container-structure-test
            "vX.Y.Z"
            "--image foo --config bar"
        ≡ GithubActions.Step::{
          , name = Some "Container structure test"
          , uses = Some
              "docker://gcr.io/gcp-runtimes/container-structure-test:vX.Y.Z"
          , `with` = Some
            [ { mapKey = "args", mapValue = "test --image foo --config bar" } ]
          }

let `v1.10.0` =
    {-
    This dhall is mapping a fixed version of the GoogleContainerTools/container-structure-test/
    https://console.cloud.google.com/gcr/images/gcp-runtimes/GLOBAL/container-structure-test
    commit/4c2c33ac717e4465a965ee7fd2a3c6b445c0bb3f
    -}
      "v1.10.0@sha256:78c0abfdc3696ec9fb35840d62342cf28f65d890d56beceb2113638d59f2cce8"

in  { `v1.10.0` = socialgouv/container-structure-test `v1.10.0`
    , step = socialgouv/container-structure-test
    }

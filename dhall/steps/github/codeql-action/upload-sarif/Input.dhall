{-
This dhall input is mapping a fixed version of the github/codeql-action
https://github.com/github/codeql-action/tree/codeql-bundle-20210421/upload-sarif
commit/a3a8231e64d3db0e7da0f3b56b9521dcccdfe412
-}
let Input/Optional =
      { checkout_path : Optional Text
      , matrix : Optional Text
      , sarif_file : Optional Text
      , token : Optional Text
      }

let Input/default =
      { checkout_path = None Text
      , matrix = None Text
      , sarif_file = None Text
      , token = None Text
      }

let Input/Type = Input/Optional

let Input = { Type = Input/Type, default = Input/default }

let __test__basic_input =
        assert
      :     Input::{=}
        ===  { checkout_path = None Text
             , matrix = None Text
             , sarif_file = None Text
             , token = None Text
             }

let __test__semver_input =
        assert
      :     Input::{ sarif_file = Some "trivy-results.sarif" }
        ===  { checkout_path = None Text
             , matrix = None Text
             , sarif_file = Some "trivy-results.sarif"
             , token = None Text
             }

in  Input

{-
This dhall input is mapping a fixed version of the crazy-max/ghaction-docker-meta
https://github.com/crazy-max/ghaction-docker-meta/tree/v2.3.0
commit/2e1a5c7fa42123697f82d479b551a1bbdb1bef88
-}
let Input/Required = { image-ref : Text }

let Input/Optional =
      { cache-dir : Optional Text
      , exit-code : Optional Text
      , format : Optional Text
      , ignore-unfixed : Optional Text
      , input : Optional Text
      , output : Optional Text
      , scan-type : Optional Text
      , severity : Optional Text
      , skip-dirs : Optional Text
      , template : Optional Text
      , timeout : Optional Text
      , vuln-type : Optional Text
      }

let Input/default =
      { cache-dir = None Text
      , exit-code = None Text
      , format = None Text
      , ignore-unfixed = None Text
      , input = None Text
      , output = None Text
      , scan-type = None Text
      , severity = None Text
      , skip-dirs = None Text
      , template = None Text
      , timeout = None Text
      , vuln-type = None Text
      }

let Input/Type = Input/Required ⩓ Input/Optional

let Input = { Type = Input/Type, default = Input/default }

let __test__basic_input =
        assert
      :   Input::{
          , image-ref = "docker.io/my-organization/my-app:\${{ github.sha }}"
          }
        ≡ { cache-dir = None Text
          , exit-code = None Text
          , format = None Text
          , ignore-unfixed = None Text
          , image-ref = "docker.io/my-organization/my-app:\${{ github.sha }}"
          , input = None Text
          , output = None Text
          , scan-type = None Text
          , severity = None Text
          , skip-dirs = None Text
          , template = None Text
          , timeout = None Text
          , vuln-type = None Text
          }

let __test__semver_input =
        assert
      :   Input::{
          , image-ref = "docker.io/my-organization/my-app:\${{ github.sha }}"
          , format = Some "table"
          }
        ≡ { cache-dir = None Text
          , exit-code = None Text
          , format = Some "table"
          , ignore-unfixed = None Text
          , image-ref = "docker.io/my-organization/my-app:\${{ github.sha }}"
          , input = None Text
          , output = None Text
          , scan-type = None Text
          , severity = None Text
          , skip-dirs = None Text
          , template = None Text
          , timeout = None Text
          , vuln-type = None Text
          }

in  Input

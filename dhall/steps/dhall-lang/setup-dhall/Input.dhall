{-
This dhall input is mapping a fixed version of the crazy-max/ghaction-docker-meta
https://github.com/crazy-max/ghaction-docker-meta/tree/v2.3.0
commit/2e1a5c7fa42123697f82d479b551a1bbdb1bef88
-}
let Input/Optional = { github_token : Optional Text, version : Optional Text }

let Input/default = { github_token = None Text, version = None Text }

let Input/Type = Input/Optional

let Input = { Type = Input/Type, default = Input/default }

let __test__basic_input =
      assert : Input::{=} === { github_token = None Text, version = None Text }

let __test__semver_input =
        assert
      :     Input::{
            , github_token = Some "\${{ github.token }}"
            , version = Some "vX.Y.Z"
            }
        ===  { github_token = Some "\${{ github.token }}"
             , version = Some "vX.Y.Z"
             }

in  Input

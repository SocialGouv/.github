{-
This dhall input is mapping a fixed version of the crazy-max/ghaction-docker-meta
https://github.com/crazy-max/ghaction-docker-meta/tree/v2.3.0
commit/2e1a5c7fa42123697f82d479b551a1bbdb1bef88
-}
let Input/Required = { images : Text }

let Input/Optional =
      { github-token : Optional Text
      , flavor : Optional Text
      , labels : Optional Text
      , sep-labels : Optional Text
      , sep-tags : Optional Text
      , tags : Optional Text
      }

let Input/default =
      { github-token = None Text
      , flavor = None Text
      , labels = None Text
      , sep-labels = None Text
      , sep-tags = None Text
      , tags = None Text
      }

let Input/Type = Input/Required ⩓ Input/Optional

let Input = { Type = Input/Type, default = Input/default }

let __test__basic_input =
        assert
      :   Input::{ images = "name/app" }
        ≡ { flavor = None Text
          , github-token = None Text
          , images = "name/app"
          , labels = None Text
          , sep-labels = None Text
          , sep-tags = None Text
          , tags = None Text
          }

let __test__semver_input =
        assert
      :   Input::{
          , images = "name/app"
          , tags = Some
              ''
              type=ref,event=branch
              type=ref,event=pr
              type=semver,pattern={{version}}
              type=semver,pattern={{major}}.{{minor}}
              ''
          }
        ≡ { flavor = None Text
          , github-token = None Text
          , images = "name/app"
          , labels = None Text
          , sep-labels = None Text
          , sep-tags = None Text
          , tags = Some
              ''
              type=ref,event=branch
              type=ref,event=pr
              type=semver,pattern={{version}}
              type=semver,pattern={{major}}.{{minor}}
              ''
          }

in  Input

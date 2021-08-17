{-
This dhall input is mapping a fixed version of the crazy-max/ghaction-docker-meta
https://github.com/crazy-max/ghaction-docker-meta/tree/v3.4.1
commit/8b842e721d38d18bea23b57f4c040e53331f4ca2
-}
let Input/Required = { images : Text }

let Input/Optional =
      { github-token : Optional Text
      , flavor : Optional Text
      , labels : Optional Text
      , sep-labels : Optional Text
      , sep-tags : Optional Text
      , tags : Optional Text
      , bake-target : Optional Text
      }

let Input/default =
      { github-token = None Text
      , flavor = None Text
      , labels = None Text
      , sep-labels = None Text
      , sep-tags = None Text
      , tags = None Text
      , bake-target = None Text
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
          , bake-target = None Text
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
          , bake-target = None Text
          }

in  Input

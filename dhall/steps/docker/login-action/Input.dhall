{-
This dhall input is mapping a fixed version of the docker/login-action
https://github.com/docker/login-action/tree/v1.8.0
commit/f3364599c6aa293cdc2b8391b1b56d0c30e45c8a
-}
let Input/Optional =
      { logout : Optional Text
      , password : Optional Text
      , registry : Optional Text
      , username : Optional Text
      }

let Input/default =
      { logout = None Text
      , password = None Text
      , registry = None Text
      , username = None Text
      }

let Input/Type = Input/Optional

let Input = { Type = Input/Type, default = Input/default }

let __test__default =
        assert
      :     Input::{=}
        ===  { logout = None Text
             , password = None Text
             , registry = None Text
             , username = None Text
             }

let __test__ghcr_io =
        assert
      :     Input::{
            , password = Some "\${{ secrets.CR_PAT }}"
            , registry = Some "ghcr.io"
            , username = Some "\${{ github.repository_owner }}"
            }
        ===  { logout = None Text
             , password = Some "\${{ secrets.CR_PAT }}"
             , registry = Some "ghcr.io"
             , username = Some "\${{ github.repository_owner }}"
             }

in  Input

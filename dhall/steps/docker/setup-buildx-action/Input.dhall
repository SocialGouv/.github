{-
This dhall input is mapping a fixed version of the docker/setup-buildx-action
https://github.com/docker/setup-buildx-action/tree/v1.1.2
commit/2a4b53665e15ce7d7049afb11ff1f70ff1610609
-}
let Input/Optional =
      { buildkitd-flags : Optional Text
      , driver : Optional Text
      , driver-opts : Optional Text
      , endpoint : Optional Text
      , install : Optional Text
      , use : Optional Text
      , version : Optional Text
      }

let Input/default =
      { buildkitd-flags = None Text
      , driver = None Text
      , driver-opts = None Text
      , endpoint = None Text
      , install = None Text
      , use = None Text
      , version = None Text
      }

let Input/Type = Input/Optional

let Input = { Type = Input/Type, default = Input/default }

let __test__default =
        assert
      :     Input::{=}
        ===  { buildkitd-flags = None Text
             , driver = None Text
             , driver-opts = None Text
             , endpoint = None Text
             , install = None Text
             , use = None Text
             , version = None Text
             }

let __test__disable_install =
        assert
      :     Input::{ install = Some "false" }
        ===  { buildkitd-flags = None Text
             , driver = None Text
             , driver-opts = None Text
             , endpoint = None Text
             , install = Some "false"
             , use = None Text
             , version = None Text
             }

in  Input

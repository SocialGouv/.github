{-
This dhall input is mapping a fixed version of the docker/build-push-action
https://github.com/docker/build-push-action/tree/v2.4.0
commit/e1b7f96249f2e4c8e4ac1519b9608c0d48944a1f
-}
let Input/Optional =
      { allow : Optional Text
      , build-args : Optional Text
      , builder : Optional Text
      , cache-from : Optional Text
      , cache-to : Optional Text
      , context : Optional Text
      , file : Optional Text
      , github-token : Optional Text
      , labels : Optional Text
      , load : Optional Text
      , network : Optional Text
      , no-cache : Optional Text
      , outputs : Optional Text
      , platforms : Optional Text
      , pull : Optional Text
      , push : Optional Text
      , secret-files : Optional Text
      , secrets : Optional Text
      , ssh : Optional Text
      , tags : Optional Text
      , target : Optional Text
      }

let Input/default =
      { allow = None Text
      , build-args = None Text
      , builder = None Text
      , cache-from = None Text
      , cache-to = None Text
      , context = None Text
      , file = None Text
      , github-token = None Text
      , labels = None Text
      , load = None Text
      , network = None Text
      , no-cache = None Text
      , outputs = None Text
      , platforms = None Text
      , pull = None Text
      , push = None Text
      , secret-files = None Text
      , secrets = None Text
      , ssh = None Text
      , tags = None Text
      , target = None Text
      }

let Input/Type = Input/Optional

let Input = { Type = Input/Type, default = Input/default }

let __test__default =
        assert
      :     Input::{=}
        ===  { allow = None Text
             , build-args = None Text
             , builder = None Text
             , cache-from = None Text
             , cache-to = None Text
             , context = None Text
             , file = None Text
             , github-token = None Text
             , labels = None Text
             , load = None Text
             , network = None Text
             , no-cache = None Text
             , outputs = None Text
             , platforms = None Text
             , pull = None Text
             , push = None Text
             , secret-files = None Text
             , secrets = None Text
             , ssh = None Text
             , tags = None Text
             , target = None Text
             }

let __test__push =
        assert
      :     Input::{ push = Some "true" }
        ===  { allow = None Text
             , build-args = None Text
             , builder = None Text
             , cache-from = None Text
             , cache-to = None Text
             , context = None Text
             , file = None Text
             , github-token = None Text
             , labels = None Text
             , load = None Text
             , network = None Text
             , no-cache = None Text
             , outputs = None Text
             , platforms = None Text
             , pull = None Text
             , push = Some "true"
             , secret-files = None Text
             , secrets = None Text
             , ssh = None Text
             , tags = None Text
             , target = None Text
             }

in  Input

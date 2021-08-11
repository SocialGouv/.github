let GithubActions =
      ../../../github-actions/package.dhall sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let Input =
      ./Input.dhall sha256:0f0b7f02193300dd1fb74da365542d2244ad42b5c5b5cbb22968552dfb62fae8

let utils =
      ../../utils.dhall sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

let step
    : ∀(ref : Text) → ∀(opts : Input.Type) → GithubActions.Step.Type
    = λ(ref : Text) →
      λ(opts : Input.Type) →
        GithubActions.Step::{
        , uses = Some "crazy-max/ghaction-docker-meta@${ref}"
        , `with` = Some
            ( utils.withInputs
                (toMap opts.{ images })
                ( toMap
                    (opts ⫽ { images = None Text, action_version = None Text })
                )
            )
        }

let __test__minimal =
        assert
      :   step "vX.Y.Z" Input::{ images = "ghcr.io/foo/bar" }
        ≡ GithubActions.Step::{
          , uses = Some "crazy-max/ghaction-docker-meta@vX.Y.Z"
          , `with` = Some (toMap { images = "ghcr.io/foo/bar" })
          }

let __test__tags_options =
        assert
      :   step
            "vX.Y.Z"
            Input::{ images = "ghcr.io/foo/bar", tags = Some "vX.Y.Z" }
        ≡ GithubActions.Step::{
          , uses = Some "crazy-max/ghaction-docker-meta@vX.Y.Z"
          , `with` = Some
            [ { mapKey = "tags", mapValue = "vX.Y.Z" }
            , { mapKey = "images", mapValue = "ghcr.io/foo/bar" }
            ]
          }

let __test__step_id =
        assert
      :     step "vX.Y.Z" Input::{ images = "ghcr.io/foo/bar" }
          ⫽ { id = Some "docker_meta" }
        ≡ GithubActions.Step::{
          , id = Some "docker_meta"
          , uses = Some "crazy-max/ghaction-docker-meta@vX.Y.Z"
          , `with` = Some (toMap { images = "ghcr.io/foo/bar" })
          }

let `v2.3.0` =
    {-
    This dhall is mapping a fixed version of the crazy-max/ghaction-docker-meta
    https://github.com/crazy-max/ghaction-docker-meta/tree/v2.3.0
    commit/2e1a5c7fa42123697f82d479b551a1bbdb1bef88
    -}
      "2e1a5c7fa42123697f82d479b551a1bbdb1bef88"

in  { `v2.3.0` = step `v2.3.0`, step }

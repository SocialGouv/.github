let GithubActions =
      ../../../github-actions/package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

let Input =
      ./Input.dhall
        sha256:13389a7e95be60f9244ea39600f8fd59b44ba5883c5e9458535e972483a000a7

let utils =
      ../../utils.dhall
        sha256:52b53ac4f7bfc0ac42b2147a16166eea9b4ed92ab303c1e6ba255c450747d3da

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

let {- renovate(github-action): depName=docker/login-action currentValue=v3 -}
    v3 =
      "f6efe56d565add159ad605568120f5b22712a870"

in  { v3 = step v3, v3/sha = v3, step }

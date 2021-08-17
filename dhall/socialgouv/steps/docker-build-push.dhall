let GithubActions =
      ../../github-actions/package.dhall
        sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let build-push-action =
      ../../steps/docker/build-push-action/package.dhall
        sha256:6459561f20b37d395cbb1170ad5343ed9cd146a03e1c2ffa75d68012f1c2d8b4

let socialgouv/docker-build-push =
      λ ( args
        : { context : Text
          , docker_buildx_step_id : Text
          , docker_meta_step_id : Text
          }
        ) →
          build-push-action.v2
            build-push-action.Input::{
            , builder = Some
                "\${{ steps.${args.docker_buildx_step_id}.outputs.name }}"
            , cache-from = Some "type=gha"
            , cache-to = Some "type=gha,mode=max"
            , context = Some "./${args.context}"
            , labels = Some
                "\${{ steps.${args.docker_meta_step_id}.outputs.labels }}"
            , push = Some "true"
            , tags = Some
                "\${{ steps.${args.docker_meta_step_id}.outputs.tags }}"
            }
        ⫽ { name = Some "Push" }

let __test__foo =
        assert
      :   socialgouv/docker-build-push
            { context = "foo"
            , docker_buildx_step_id = "docker_buildx"
            , docker_meta_step_id = "docker_meta"
            }
        ≡ GithubActions.Step::{
          , name = Some "Push"
          , uses = Some "docker/build-push-action@${build-push-action.v2/sha}"
          , `with` = Some
            [ { mapKey = "builder"
              , mapValue = "\${{ steps.docker_buildx.outputs.name }}"
              }
            , { mapKey = "cache-from", mapValue = "type=gha" }
            , { mapKey = "cache-to", mapValue = "type=gha,mode=max" }
            , { mapKey = "context", mapValue = "./foo" }
            , { mapKey = "labels"
              , mapValue = "\${{ steps.docker_meta.outputs.labels }}"
              }
            , { mapKey = "push", mapValue = "true" }
            , { mapKey = "tags"
              , mapValue = "\${{ steps.docker_meta.outputs.tags }}"
              }
            ]
          }

in  socialgouv/docker-build-push

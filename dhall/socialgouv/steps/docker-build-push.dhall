let GithubActions =
      ../../github-actions/package.dhall sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let build-push-action =
      ../../steps/docker/build-push-action/package.dhall sha256:fc04eef536f027a5796f537351756e62c25355ec18a4b0354f93a8b92d3b7e43

let socialgouv/docker-build-push =
      λ ( args
        : { cache_path : Text
          , context : Text
          , docker_buildx_step_id : Text
          , docker_meta_step_id : Text
          }
        ) →
          build-push-action.`v2.4.0`
            build-push-action.Input::{
            , builder = Some
                "\${{ steps.${args.docker_buildx_step_id}.outputs.name }}"
            , cache-from = Some "type=local,src=${args.cache_path}"
            , cache-to = Some "type=local,dest=${args.cache_path}"
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
            { cache_path = "/tmp/.buildx-cache"
            , context = "foo"
            , docker_buildx_step_id = "docker_buildx"
            , docker_meta_step_id = "docker_meta"
            }
        ≡ GithubActions.Step::{
          , name = Some "Push"
          , uses = Some
              "docker/build-push-action@e1b7f96249f2e4c8e4ac1519b9608c0d48944a1f"
          , `with` = Some
            [ { mapKey = "builder"
              , mapValue = "\${{ steps.docker_buildx.outputs.name }}"
              }
            , { mapKey = "cache-from"
              , mapValue = "type=local,src=/tmp/.buildx-cache"
              }
            , { mapKey = "cache-to"
              , mapValue = "type=local,dest=/tmp/.buildx-cache"
              }
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

let GithubActions =
      ../../github-actions/package.dhall
        sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let setup-buildx-action =
      ../../steps/docker/setup-buildx-action/package.dhall
        sha256:d8028126cab54e33fb9fcba453aef7076b6c860b714eece26ae49d92b4557dcf

let socialgouv/docker-buildx =
          setup-buildx-action.v1 setup-buildx-action.Input::{=}
      //  { name = Some "Set up Docker Buildx" }

let __test__foo =
        assert
      :     socialgouv/docker-buildx
        ===  GithubActions.Step::{
             , name = Some "Set up Docker Buildx"
             , uses = Some
                 "docker/setup-buildx-action@${setup-buildx-action.v1/sha}"
             , `with` = Some ([] : List { mapKey : Text, mapValue : Text })
             }

in  socialgouv/docker-buildx

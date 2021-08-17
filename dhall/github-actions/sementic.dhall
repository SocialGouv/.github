let GithubActions =
      ./package.dhall sha256:66b276bb67cca4cfcfd1027da45857cc8d53e75ea98433b15dade1e1e1ec22c8

let releases_branches =
      [ "master"
      , "next"
      , "next-major"
      , "beta"
      , "alpha"
      , "+([0-9])?(.{+([0-9]),x}).x"
      ]

let OnReleaseBranches =
      GithubActions.On::{
      , push = Some GithubActions.Push::{ branches = Some releases_branches }
      }

in  { OnReleaseBranches, releases_branches }

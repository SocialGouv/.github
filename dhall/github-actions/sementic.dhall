let GithubActions =
      ./package.dhall
        sha256:53da2310a2e009556455a73684b997c3bd53192637ac3c77562c30e3815f5f23

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

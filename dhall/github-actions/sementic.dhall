let GithubActions =
      ./package.dhall sha256:2bbfa9dca70fcfb23b1382e737768a6447d766bcc4b8f2ef1141dd6b94cc5fee

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

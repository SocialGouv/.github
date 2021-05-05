let GithubActions =
      ./package.dhall sha256:327d499ebf1ec63e5c3b0b0d5285b78a07be4ad1a941556eb35f67547004545f

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

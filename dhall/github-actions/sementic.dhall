let GithubActions =
      ./package.dhall
        sha256:689f05f7e4f9e6355b8ce935ca0568b1a1fdbbd746e0bc4e2e5d8f238cfa4358

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

{ container-structure-test =
    ./steps/container-structure-test.dhall sha256:39e1bda1b6947c0e4035dd08e5b2a147de4b96f18ea251213db9edd7018dc098
, docker-meta =
    ./steps/docker-meta.dhall sha256:eb33151d23c230a302df1e1c3e885af23d5715558e8d9e7b215aa35eeac61f0e
, docker-buildx =
    ./steps/docker-buildx.dhall sha256:40cd835f0c5d748ac6ba97b2a420fbf6a2f33511565f7dcc3d3788f93db96a5b
, docker-login =
    ./steps/docker-login.dhall sha256:fe2771a065191fe3787d9cfe309d7ab031366ac6d97bfef51719afb9cf534f46
, docker-build-push =
    ./steps/docker-build-push.dhall sha256:6b7d3ebadd484a60eb7dca2a9bc376d34ce05bca154c15a968f78f8f50e7346d
}

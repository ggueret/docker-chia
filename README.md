# docker-chia

## Build a specific Chia version

```
GIT_REVISION=1.1.5 make build
```

The builded Docker image will be tagged using the `GIT_REVISION`, by default the value is `main`.

To show help with on a Chia 1.1.5 container, it would look like this: `docker run --rm ggueret/docker-chia:1.1.5 -h`.
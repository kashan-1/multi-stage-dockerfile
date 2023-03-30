# Multi-stage-dockerfile
This repository contains multi stagging app deployment on docker(node, python)

This command is use to build docker image using `Dockerfile`(no cache)
```bash
docker build --no-cache --tag stage-img .
```

This command simply run our `multi-stage image/container` on docker 

```bash
docker run -p 5000:5000 stage-img
```



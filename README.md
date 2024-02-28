# Modul 324 Devops

## Augabe 1
Ich habe die Ref-card-02 in einen eigenen Branch kopiert. Zusätzlich habe ich einen Workflow definiert welcher bei einem gemergeden Pull-Request auf den Branch "dockerhub" läüft.
Dieser Workflow nimmt das Dockerfile, welchhes ich geschrieben habe, buildet es und pushed es auf Docker Hub.

Worflow:
```yaml
name: "Build and Push to Server"
on:
  pull_request:
    branches: [dockerhub]
    types:
      - closed

env:
  working-directroy: ./

jobs:
  if_merged:
    if: github.event.pull_request.merged == true
    runs-on: ubuntu-latest
    steps:
      - name: Check out the repo
        uses: actions/checkout@v4

      - name: Log in to Docker Hub
        uses: docker/login-action@f4ef78c080cd8ba55a85445d5b36e214a81df20a
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Extract metadata (tags, labels) for Docker
        id: meta
        uses: docker/metadata-action@9ec57ed1fcdbf14dcef7dfbe97b2010124a938b7
        with:
          images: aelelliotbanyardbbw/m324-devops

      - name: Build and push Docker image
        uses: docker/build-push-action@3b5e8027fcad23fda98b2e3ac259d8d67585f671
        with:
          context: .
          file: ./Dockerfile
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
```
Dockerfile:
```
FROM node:latest
WORKDIR /
RUN git clone --single-branch --branch docker https://github.com/AelElliotBanyard/324_devops.git
WORKDIR /324_devops
EXPOSE 3000
ENTRYPOINT ["npm", "run", "start"]
```


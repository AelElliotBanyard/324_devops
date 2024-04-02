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

Github Action Run:
![Github Action](image.png)

Ablauf:
Ich habe das gitlab projekt ohne probleme auf meinen github account kopiert. Anschliessend habe ich einen neuen Branch erstellt und die Ref-card-02 in diesen Branch kopiert. Danach habe ich ein Dockerfile geschrieben und einen Workflow definiert welcher bei einem gemergeden Pull-Request auf den Branch "dockerhub" läüft. Dieser Workflow nimmt das Dockerfile, welchhes ich geschrieben habe, buildet es und pushed es auf Docker Hub.
Beim pushen auf Docker Hub hatte ich einige Probleme, aber dies lag daran, dass ich den Workflow nicht richtig definiert hatte. Nachdem ich dies korrigiert hatte, funktionierte es einwandfrei.

## Augabe 2

Bei der Aufgabe 2 hatte ich erstmals ein Problem mit GitHub Registry Container. Ich habe den Workflow so definiert, dass er das Dockerfile buildet und auf GitHub Container Registry pusht. Dies hat jedoch nicht funktioniert. Ich hatte vergessen, die nötigen Berechtigungen zu erteilen. Nachdem ich dies gemacht hatte, funktionierte es einwandfrei.

Workflow:

```yaml
name: "Build and Push to GHCR"
on:
  push:
    branches:
      - ghcr

env:
  working-directroy: ./

jobs:
  GHCR:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - name: Check out the repo
        uses: actions/checkout@v4

      - name: "Login to GitHub Container Registry"
        uses: docker/login-action@v1
        with:
          registry: ghcr.io
          username: ${{github.actor}}
          password: ${{secrets.GITHUB_TOKEN}}

      - name: "Build Inventory Image"
        run: |
          docker build . --tag ghcr.io/aelelliotbanyard/store:latest
          docker push ghcr.io/aelelliotbanyard/store:latest
```

Das Dockerfile ist das gleiche wie in der Aufgabe 1.

GitHub Action Run:
![Github Action Run](image-1.png)

Weitere Aufgaben:
Ich wollte die ECS und ECR aufgaben Erledigen jedoch hatte ich keinen zugriff auf das Learner Lab

#!/bin/bash

docker run --rm committed/ci java --version
docker run --rm committed/ci mvn --version
echo "Node version $(docker run --rm committed/ci node --version)"
echo "Yarn version $(docker run --rm committed/ci yarn --version)"
docker run --rm committed/ci gcloud --version
echo "Helm version $(docker run --rm committed/ci helm version -c --short)"
docker run --rm committed/ci ansible --version
docker run --rm committed/ci google-chrome --version
docker run --rm committed/ci conda --version
docker run --rm committed/ci python -V

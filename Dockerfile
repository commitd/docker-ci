FROM adoptopenjdk/openjdk11:x86_64-ubuntu-jdk-11.0.2.9
LABEL maintainer="Committed Software <docker@committed.software>"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV NODE_VERSION 12
ENV HELM_VERSION 2.9.1
ENV ANACONDA3_VERSION 5.3.0
ENV DOCKER_VERSION=19.03.7
ENV DOCKER_COMPOSE_VERSION=1.25.4
ENV CLOUD_SDK_REPO cloud-sdk-cosmic
ENV PATH /opt/conda/bin:$PATH

# Prereqs
RUN apt-get update && apt-get install -qq \
    curl \
    gnupg \
    apache2-utils \
    tar \
    zip \
    wget \
    git \
    build-essential

# Maven
RUN apt-get install -qq maven

# Node
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
    yarn


# Helm
RUN wget https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz && tar -zxvf helm-v$HELM_VERSION-linux-amd64.tar.gz && \
    cp linux-amd64/helm /usr/local/bin

# GCloud
RUN echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install -qq \
    google-cloud-sdk


# Kubectl
RUN apt-get install -y apt-transport-https && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && apt-get install -qq \
    kubectl

RUN mkdir -p /.kube && chmod -R 0755 /.kube

# Ansible
RUN apt-get install -y python-pip && pip install --user openshift passlib
RUN apt-get install software-properties-common -y && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -qq \
    ansible

# Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Anaconda
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-${ANACONDA3_VERSION}-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Docker-cli
RUN wget --quiet https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz && \
    tar -xzvf docker-${DOCKER_VERSION}.tgz --strip 1 -C /usr/local/bin docker/docker && \
    rm docker-${DOCKER_VERSION}.tgz

# Docker-compose
RUN curl -s -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# AWS
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip -q awscliv2.zip && \
    ./aws/install && \
    rm awscliv2.zip

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

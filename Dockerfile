FROM adoptopenjdk/openjdk11:x86_64-ubuntu-jdk-11.0.2.9

# Prereqs
RUN apt-get update && apt-get install curl gnupg apache2-utils tar wget -y

# Helm
RUN wget https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz && tar -zxvf helm-v2.9.1-linux-amd64.tar.gz && \
    cp linux-amd64/helm /usr/local/bin

# GCloud
RUN export CLOUD_SDK_REPO="cloud-sdk-cosmic" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

# Kubectl
RUN apt-get install -y apt-transport-https && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    apt-get update && \
    apt-get install -y kubectl

# Ansible
RUN apt-get install -y python-pip && pip install --user openshift passlib
RUN apt-get install software-properties-common -y && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install ansible -y

RUN apt-get install maven git -y

RUN gcloud --version
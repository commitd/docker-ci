# committed/ci

[![Docker Build Status](https://img.shields.io/docker/cloud/build/committed/ci?style=flat-square)](https://hub.docker.com/r/committed/ci)
[![Docker Pulls](https://img.shields.io/docker/pulls/committed/ci?style=flat-square)](https://hub.docker.com/r/committed/ci)

A docker image for use in CI builds. It is setup for the technologies and stack that are most commonly used in Committed projects, but may be useful to others for use or reference.

## Contents

The following general libs and utilities are installed:

- curl
- gnupg
- apache2-utils
- tar
- zip
- wget
- git
- build-essential

The build tools included are:

```
openjdk 14.0.1 2020-04-14
OpenJDK Runtime Environment AdoptOpenJDK (build 14.0.1+7)
OpenJDK 64-Bit Server VM AdoptOpenJDK (build 14.0.1+7, mixed mode, sharing)
Apache Maven 3.6.0
Maven home: /usr/share/maven
Java version: 14.0.1, vendor: AdoptOpenJDK, runtime: /opt/java/openjdk
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "4.19.76-linuxkit", arch: "amd64", family: "unix"
Node version v12.18.2
Yarn version 1.22.4
Google Cloud SDK 300.0.0
alpha 2020.07.06
beta 2020.07.06
bq 2.0.58
core 2020.07.06
gsutil 4.51
kubectl 1.15.11
Helm version Client: v2.9.1+g20adb27
ansible 2.9.10
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.17 (default, Apr 15 2020, 17:20:14) [GCC 7.5.0]
Google Chrome 85.0.4183.15 dev
conda 4.5.11
Python 3.7.0
Docker version 19.03.7, build 7141c199a2
docker-compose version 1.25.4, build 8d51620a
aws-cli/2.0.30 Python/3.7.3 Linux/4.19.76-linuxkit botocore/2.0.0dev34
```

## Use

The simplest use in a drone pipeline is shown below, you just have to provide the build commands, here shown as `build.sh`, but `java`, `mvn`, `node` and `yarn` commands can be used. In addition, deploy steps using `gcloud`, `kubectl` and `ansible`.

```yaml
- name: build
  image: committed/ci
  commands:
    - build.sh
```

To use docker, connect to the Docker daemon on the host machine by mounting the Docker socket as a volume:

```yaml
- name: build
  image: committed/ci
  commands:
    - docker ps
  volumes:
    - name: docker_sock
      path: /var/run/docker.sock

...

volumes:
  - name: docker_sock
    host:
      path: /var/run/docker.sock
```

## Development

To build the docker image run:

```bash
./build.sh
```

### Testing

To test the docker image run the docker image with appropriate command e.g.:

```docker
docker run --rm  committed/ci java --version
```

A test file `./test.sh` uses the version commands of each tool to check it is installed. The tests (`ci_tests.sh`) are run on dockerhub with and `docker-compose.test.yml`.

## Credits

This is based on the original openjdk image by [adoptopenjdk](https://hub.docker.com/r/adoptopenjdk).

## License

The Dockerfiles and associated scripts are licensed under the Apache License, Version 2.0.

Licenses for the products installed within the images:

- OpenJDK: [GNU GPL v2 with Classpath Exception](https://openjdk.java.net/legal/gplv2+ce.html)
- Maven: [Apache License, Version 2.0.](https://maven.apache.org/ref/3.0/license.html)
- Node: https://github.com/nodejs/node/blob/master/LICENSE
- Yarn: [BSD](https://github.com/yarnpkg/yarn/blob/master/LICENSE)
- GCloud/Kubectl: Apache License, Version 2.0. and [GCloud Terms](https://cloud.google.com/terms/)
- Ansible: [GPL v3.0](https://github.com/ansible/ansible/blob/devel/COPYING)
- Google Chrome [EULA](https://www.google.com/intl/en_sg/chrome/privacy/eula_text.html)
- Anaconda [EULA](https://docs.anaconda.com/anaconda/eula/)
- Docker [Apache License, Version 2.0.](https://github.com/docker/docker/blob/master/LICENSE)
- AWS [Apache License, Version 2.0.](https://github.com/aws/aws-cli/blob/develop/LICENSE.txt) 

As with all Docker images, other software is likely to be included, which might be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

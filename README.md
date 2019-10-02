# committed/ci

[![Docker Build Status](https://img.shields.io/docker/cloud/build/committed/ci?style=flat-square)](https://cloud.docker.com/u/committed/repository/docker/committed/ci/builds)
[![Docker Pulls](https://img.shields.io/docker/pulls/committed/ci?style=flat-square)](https://hub.docker.com/r/committed/ci)

A docker image for use in CI builds. It is setup for the technologies and stack that are most commonly used in Committed projects, but may be useful to others for use or reference.

## Contents

The following general libs and utilities are installed:

- curl
- gnupg
- apache2-utils
- tar
- wget
- git
- build-essential

The build tools included are:

- **Java** openjdk 11.0.2 2019-01-15
- **Maven** v3.6.0
- **Node** v10.16.3
- **Yarn** 1.19.0
- **Helm** v2.9.1
- **GCloud** 265
- **Kubectl** 2019.09.27
- **Ansible** 2.8.5

## Use

The simplest use in a drone pipeline is shown below, you just have to provide the build commands, here shown as `build.sh`, but `java`, `mvn`, `node` and `yarn` commands can be used. In addition, deploy steps using `gcloud`, `kubectl` and `ansible`.

```yaml
- name: build
  image: committed/ci
  commands:
    - build.sh
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

This is based on the original openjdk image by [adoptopenjdk](https://hub.docker.com/r/adoptopenjdk/openjdk11).

## License

The Dockerfiles and associated scripts are licensed under the Apache License, Version 2.0.

Licenses for the products installed within the images:

- OpenJDK: [GNU GPL v2 with Classpath Exception](https://openjdk.java.net/legal/gplv2+ce.html)
- Maven: [Apache License, Version 2.0.](https://maven.apache.org/ref/3.0/license.html)
- Node: https://github.com/nodejs/node/blob/master/LICENSE
- Yarn: [BSD](https://github.com/yarnpkg/yarn/blob/master/LICENSE)
- GCloud/Kubectl: Apache License, Version 2.0. and [GCloud Terms](https://cloud.google.com/terms/)
- Ansible: [GPL v3.0](https://github.com/ansible/ansible/blob/devel/COPYING)

As with all Docker images, other software is likely to be included, which might be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

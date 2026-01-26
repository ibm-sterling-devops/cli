# Commnad Line Utility for use with IBM Sterling Devops Ansible scripts
[![GitHub release](https://img.shields.io/github/v/release/ibm-sterling-devops/cli)](https://github.com/ibm-sterling-devops/cli/releases/latest)
[![Build CLI](https://github.com/ibm-sterling-devops/cli/actions/workflows/build-cli.yml/badge.svg)](https://github.com/ibm-sterling-devops/cli/actions/workflows/build-cli.yml)

## Introduction

This Code is inspired by on [IBM Maximo Application Suite CLI Utility](https://ibm-mas.github.io/cli/)

Provides:

| package        | Version | amd64 | arm64 |
|----------------|---------|-------|-------|
| python3        | 3.14    |  ✔️   |  ✔️  |
| helm           | 3       |  ✔️   |  ✔️  |
| oc             |         |  ✔️   |  ✔️  |
| oc ibm-pak     |         |  ✔️   |  ✔️  |
| vim            |         |  ✔️   |  ✔️  |
| jq             |         |  ✔️   |  ✔️  |
| yq             |         |  ✔️   |  ✔️  |
| rclone         |         |  ✔️   |  ✔️  |
| kubectl        |         |  ✔️   |  ✔️  |
| ibmcloud       |         |  ✔️   |  ✔️  |


The engine that performs all tasks is written in Ansible, you can directly use the same automation outside of this CLI if you wish.  The code is open source and available in [ibm-sterling-devops/ansible-ibm-sterling](https://github.com/ibm-sterling-devops/ansible-ibm-sterling).


## Building IBM Sterling CLI images manually

### Prerequisites
- Podman or Docker installed on your system
- Access to Quay.io (for publishing images)

### Build Steps

1. Clone this repository:
```bash
git clone https://github.com/ibm-sterling-devops/cli.git
```

2. Move to the image directory:
```bash
cd cli/image
```

3. Export variables:

```bash
export QUAYIO_USERNAME=<your-quay-username>
export QUAYIO_PASSWORD=<your-quay-password>
export QUAYIO_REPO=<your-quay-repository>
```

4. Before you can push your image to Quay.io, you need to log in:

```bash
podman login quay.io -u "$QUAYIO_USERNAME" -p "$QUAYIO_PASSWORD"
```

5. Build your image:
```bash
podman build --build-arg ARCHITECTURE=amd64 -t sterling-cli:1.0.0 .
```

For ARM64 architecture:
```bash
podman build --build-arg ARCHITECTURE=arm64 -t sterling-cli:1.0.0 .
```

## Test image

To run your container and start a shell session, use:

```bash
mkdir ~/sterling-workspace

cd ~/sterling-workspace

podman run -it --rm -v "$(pwd)":/workspace localhost/sterling-cli:1.0.0
```

## Publish image to Quay.io


1. Tag your image with your Quay.io repository name:

```bash
podman tag localhost/sterling-cli:1.0.0 quay.io/$QUAYIO_REPO/sterling-cli:1.0.0
```

2. Finally, push your tagged image to Quay.io:

```bash
podman push quay.io/$QUAYIO_REPO/sterling-cli:1.0.0
```

## Want to contribute to IBM Sterling - Command Line Interface?
We welcome every Maximo Application Suite users, developers and enthusiasts to contribute to the IBM Sterling - Command Line Interface while fixing code issues and implementing new automated functionalities.

You can contribute to this collection by raising [a new issue](https://github.com/ibm-sterling-devops/cli/issues) with suggestions on how to make our MAS automation engine even better, or if you want to become a new code contributor, please refer to the [Contributing section](CONTRIBUTING.md) and learn more about how to get started.


# Contributors

See the list of [contributors](https://github.com/ibm-sterling-devops/cli/contributors) who participated in this project.

# License

This project is licensed under the Eclipse Public License - v 2.0 - see the [LICENSE.md](LICENSE.md) file for details

## Disclaimer

This product is not officially supported, and can be used as is. And any feedback will be welcome. We does not make any warranty about the completeness, reliability and accuracy of this code. Any action you take by using this code is strictly at your own risk, and this project will not be liable for any losses and damages in connection with the use of this code.
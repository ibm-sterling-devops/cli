# Commnad Line Utility for use with IBM Sterling Devops Ansible scripts
[![GitHub release](https://img.shields.io/github/v/release/ibm-sterling-devops/cli)](https://github.com/ibm-sterling-devops/cli/releases/latest)
[![Build CLI](https://github.com/ibm-sterling-devops/cli/actions/workflows/build-cli.yml/badge.svg)](https://github.com/ibm-sterling-devops/cli/actions/workflows/build-cli.yml)

## Introduction

This Code is inspired by on [IBM Maximo Application Suite CLI Utility](https://ibm-mas.github.io/cli/)

Provides:

| package        | Version | amd64 | arm64 |
|----------------|---------|-------|-------|
| python3        | 3.12    |  ✔️   |  ✔️  |
| helm           | 3.16.3  |  ✔️   |  ✔️  |
| oc             | latest  |  ✔️   |  ✔️  |
| oc ibm-pak     | 1.21.1  |  ✔️   |  ✔️  |
| rclone         | latest  |  ✔️   |  ✔️  |
| kubectl        | latest  |  ✔️   |  ✔️  |
| ibmcloud       | 2.40.0  |  ✔️   |  ✔️  |


The engine that performs all tasks is written in Ansible, you can directly use the same automation outside of this CLI if you wish.  The code is open source and available in [ibm-sterling-devops/ansible-ibm-sterling](https://github.com/ibm-sterling-devops/ansible-ibm-sterling).


## Building IBM Sterling CLI images manually

### Available Images

- **Red Hat UBI9 Python 3.12 based image** (default) - Instructions below
- **Ubuntu 24.04 based image** - See [README-ubuntu.md](README-ubuntu.md)

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
export QUAYIO_REPO=quay.io/<your-quay-repository>
```

4. Before you can push your image to Quay.io, you need to log in:

```bash
podman login quay.io -u "$QUAYIO_USERNAME" -p "$QUAYIO_PASSWORD"
```

5. Build your Red Hat UBI9 based image:

**For AMD64 architecture:**
```bash
podman build --build-arg ARCHITECTURE=amd64 -f Dockerfile.ubi9 -t sterling-cli:1.0.0 .
```

**For ARM64 architecture:**
```bash
podman build --build-arg ARCHITECTURE=arm64 -f Dockerfile.ubi9 -t sterling-cli:1.0.0 .
```

## Test Image

To run your container and start a shell session, use:

```bash
podman run -it --rm localhost/sterling-cli:1.0.0
```

## Publish Image to Quay.io

1. Tag your image with your Quay.io repository name:

```bash
podman tag localhost/sterling-cli:1.0.0 $QUAYIO_REPO/sterling-cli:1.0.0
```

2. Finally, push your tagged image to Quay.io:

```bash
podman push $QUAYIO_REPO/sterling-cli:1.0.0
```

## Build Multi-Architecture (Manifest List)

To create a multi-architecture image that supports both AMD64 and ARM64 platforms, follow these steps:

### Prerequisites
- Podman or Docker with buildx support
- Access to Quay.io (for publishing images)

### Build and Push Multi-Architecture Image

1. Build images for both architectures:

**Build AMD64 image:**
```bash
podman build --platform linux/amd64 --build-arg ARCHITECTURE=amd64 -f Dockerfile.ubi9 -t $QUAYIO_REPO/sterling-cli:1.0.0-amd64 .
```

**Build ARM64 image:**
```bash
podman build --platform linux/arm64 --build-arg ARCHITECTURE=arm64 -f Dockerfile.ubi9 -t $QUAYIO_REPO/sterling-cli:1.0.0-arm64 .
```

2. Push both architecture-specific images:

```bash
podman push $QUAYIO_REPO/sterling-cli:1.0.0-amd64
podman push $QUAYIO_REPO/sterling-cli:1.0.0-arm64
```

3. Create and push the manifest list:

```bash
podman manifest create $QUAYIO_REPO/sterling-cli:1.0.0
podman manifest add $QUAYIO_REPO/sterling-cli:1.0.0 $QUAYIO_REPO/sterling-cli:1.0.0-amd64
podman manifest add $QUAYIO_REPO/sterling-cli:1.0.0 $QUAYIO_REPO/sterling-cli:1.0.0-arm64
podman manifest push $QUAYIO_REPO/sterling-cli:1.0.0
```

4. (Optional) Create and push a `latest` tag:

```bash
podman manifest create $QUAYIO_REPO/sterling-cli:latest
podman manifest add $QUAYIO_REPO/sterling-cli:latest $QUAYIO_REPO/sterling-cli:1.0.0-amd64
podman manifest add $QUAYIO_REPO/sterling-cli:latest $QUAYIO_REPO/sterling-cli:1.0.0-arm64
podman manifest push $QUAYIO_REPO/sterling-cli:latest
```

### Verify Multi-Architecture Support

To verify that your manifest list includes both architectures:

```bash
podman manifest inspect $QUAYIO_REPO/sterling-cli:1.0.0
```

### Using the Multi-Architecture Image

Once published, users can pull the image without specifying the architecture:

```bash
podman pull $QUAYIO_REPO/sterling-cli:1.0.0
```

Podman/Docker will automatically select the appropriate architecture based on the host system.


## Want to contribute to IBM Sterling - Command Line Interface?
We welcome every Maximo Application Suite users, developers and enthusiasts to contribute to the IBM Sterling - Command Line Interface while fixing code issues and implementing new automated functionalities.

You can contribute to this collection by raising [a new issue](https://github.com/ibm-sterling-devops/cli/issues) with suggestions on how to make our Sterling automation engine even better.


# Contributors

See the list of [contributors](https://github.com/ibm-sterling-devops/cli/contributors) who participated in this project.

# License

This project is licensed under the Eclipse Public License - v 2.0 - see the [LICENSE](LICENSE) file for details

## Disclaimer

This repository is a community-driven projects and is not officially supported or endorsed by IBM. While members of the community may include IBM employees, this project is independent of IBM's official support channels. Please note that any contributions, issues, or inquiries regarding this repository should be directed to the community maintainers and not to IBM's support teams. We appreciate your understanding and participation in this community-driven initiative.

This code can be used as is. And any feedback will be welcome. We does not make any warranty about the completeness, reliability and accuracy of this code. Any action you take by using this code is strictly at your own risk, and this project will not be liable for any losses and damages in connection with the use of this code.

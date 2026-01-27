# Command Line Utility for IBM Sterling DevOps

## Introduction

This project provides a containerized environment with all the necessary tools to run [ansible-ibm-sterling](https://github.com/ibm-sterling-devops/ansible-ibm-sterling) automation scripts. The container images come pre-configured with essential CLI tools, Python packages, and dependencies required for IBM Sterling B2B Integrator deployment and management on Red Hat OpenShift and Kubernetes platforms.

**Why use this container?**
- **Consistent Environment**: Eliminates "works on my machine" issues by providing a standardized toolset
- **Multi-Architecture Support**: Available for both AMD64 and ARM64 architectures
- **Pre-configured Tools**: All required dependencies installed and ready to use
- **Ansible Ready**: Includes ansible-ibm-sterling collection and all prerequisites

This code is inspired by the [IBM Maximo Application Suite CLI Utility](https://ibm-mas.github.io/cli/).

### Included Tools

The container includes the following tools and packages:

| Package        | Version | AMD64 | ARM64 |
|----------------|---------|-------|-------|
| python3        | 3.12    |  ✔️   |  ✔️  |
| helm           | 3.16.3  |  ✔️   |  ✔️  |
| oc             | latest  |  ✔️   |  ✔️  |
| oc ibm-pak     | 1.21.1  |  ✔️   |  ✔️  |
| rclone         | latest  |  ✔️   |  ✔️  |
| kubectl        | latest  |  ✔️   |  ✔️  |
| ibmcloud       | 2.40.0  |  ✔️   |  ✔️  |

### Available Images

- **Red Hat UBI9 Python 3.12** based image (default) - Available for AMD64 and ARM64
- **Ubuntu 24.04** based image - See [README-ubuntu.md](README-ubuntu.md)

The automation engine that performs all tasks is written in Ansible. You can directly use the same automation outside of this CLI if you wish. The code is open source and available at [ibm-sterling-devops/ansible-ibm-sterling](https://github.com/ibm-sterling-devops/ansible-ibm-sterling).

## Getting Images from Quay.io

Pre-built container images are available on Quay.io for immediate use. These images support both AMD64 and ARM64 architectures.

### Pull the Latest Image

To pull a specific version:

```bash
# Using Podman
podman pull quay.io/ibm-sterling-devops/sterling-cli:1.0.0

# Using Docker
docker pull quay.io/ibm-sterling-devops/sterling-cli:1.0.0
```

### Run the Container

After pulling the image, you can run it interactively:

```bash
# Using Podman
podman run -it --rm quay.io/ibm-sterling-devops/sterling-cli:1.0.0

# Using Docker
docker run -it --rm quay.io/ibm-sterling-devops/sterling-cli:1.0.0
```

### Mount Local Directories

To work with local files and configurations, mount your workspace directory:

```bash
# Using Podman
podman run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  quay.io/ibm-sterling-devops/sterling-cli:latest

# Using Docker
docker run -it --rm \
  -v $(pwd):/workspace \
  -w /workspace \
  quay.io/ibm-sterling-devops/sterling-cli:latest
```

### Architecture-Specific Images

The manifest list automatically selects the correct architecture for your system. If you need to explicitly pull a specific architecture:

```bash
# AMD64
podman pull quay.io/ibm-sterling-devops/sterling-cli:1.0.0-amd64

# ARM64
podman pull quay.io/ibm-sterling-devops/sterling-cli:1.0.0-arm64
```

## Building IBM Sterling CLI Images Manually

If you need to customize the container or build it yourself, follow these instructions.

### Prerequisites

- Podman or Docker installed on your system
- Access to Quay.io (for publishing images)

### Build Steps

1. Clone this repository:
```bash
git clone https://github.com/ibm-sterling-devops/cli.git
cd cli
```

2. Export variables and login to Quay.io (optional, only if publishing):

```bash
export QUAYIO_USERNAME=<your-quay-username>
export QUAYIO_PASSWORD=<your-quay-password>
export QUAYIO_REPO=quay.io/<your-quay-repository>

podman login quay.io -u "$QUAYIO_USERNAME" -p "$QUAYIO_PASSWORD"
```

3. Build your Red Hat UBI9 based image:

Move to the image directory:

```bash
cd image
```

For AMD64 architecture:
```bash
podman build --build-arg ARCHITECTURE=amd64 -f Dockerfile.ubi9 -t sterling-cli:1.0.0 .
```

For ARM64 architecture:
```bash
podman build --build-arg ARCHITECTURE=arm64 -f Dockerfile.ubi9 -t sterling-cli:1.0.0 .
```

4. Test the image:

To run your container and start a shell session:

```bash
podman run -it --rm localhost/sterling-cli:1.0.0
```

### Build and Push Multi-Architecture Image

You can build each architecture on its native machine and then create the manifest list from any machine.

This approach is recommended when:
- You have native hardware for each architecture (faster builds, no emulation overhead)
- Cross-platform builds fail or are too slow
- You want to ensure optimal performance for each architecture

Export variables and login to Quay.io:

```bash
export QUAYIO_USERNAME=<your-quay-username>
export QUAYIO_PASSWORD=<your-quay-password>
export QUAYIO_REPO=quay.io/<your-quay-repository>

podman login quay.io -u "$QUAYIO_USERNAME" -p "$QUAYIO_PASSWORD"
```

**On AMD64 machine:**
```bash
podman build --build-arg ARCHITECTURE=amd64 -f Dockerfile.ubi9 -t $QUAYIO_REPO/sterling-cli:1.0.0-amd64 .
podman push $QUAYIO_REPO/sterling-cli:1.0.0-amd64
```

**On ARM64 machine:**
```bash
podman build --build-arg ARCHITECTURE=arm64 -f Dockerfile.ubi9 -t $QUAYIO_REPO/sterling-cli:1.0.0-arm64 .
podman push $QUAYIO_REPO/sterling-cli:1.0.0-arm64
```

**On any machine (create manifest list):**
```bash
podman manifest create $QUAYIO_REPO/sterling-cli:1.0.0
podman manifest add $QUAYIO_REPO/sterling-cli:1.0.0 $QUAYIO_REPO/sterling-cli:1.0.0-amd64
podman manifest add $QUAYIO_REPO/sterling-cli:1.0.0 $QUAYIO_REPO/sterling-cli:1.0.0-arm64
podman manifest push $QUAYIO_REPO/sterling-cli:1.0.0
```

## Want to Contribute?

We welcome IBM Sterling users, developers, and enthusiasts to contribute to the IBM Sterling Command Line Interface by fixing code issues and implementing new automated functionalities.

You can contribute to this project by raising [a new issue](https://github.com/ibm-sterling-devops/cli/issues) with suggestions on how to make our Sterling automation engine even better.

## Contributors

See the list of [contributors](https://github.com/ibm-sterling-devops/cli/contributors) who participated in this project.

## License

This project is licensed under the Eclipse Public License - v 2.0 - see the [LICENSE](LICENSE) file for details.

## Troubleshooting

For common issues and solutions, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Disclaimer

This repository is a community-driven project and is not officially supported or endorsed by IBM. While members of the community may include IBM employees, this project is independent of IBM's official support channels. Please note that any contributions, issues, or inquiries regarding this repository should be directed to the community maintainers and not to IBM's support teams. We appreciate your understanding and participation in this community-driven initiative.

This code can be used as is, and any feedback will be welcome. We do not make any warranty about the completeness, reliability, and accuracy of this code. Any action you take by using this code is strictly at your own risk, and this project will not be liable for any losses and damages in connection with the use of this code.

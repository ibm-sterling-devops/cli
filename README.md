# Commnad Line Utility for use with IBM Sterling Devops Ansible scripts

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

**Available Images**

- Red Hat UBI9 Python 3.12 based image (default) on plataform amd64 and arm64
- Ubuntu 24.04 based image - See [README-ubuntu.md](README-ubuntu.md)

The engine that performs all tasks is written in Ansible, you can directly use the same automation outside of this CLI if you wish.  The code is open source and available in [ibm-sterling-devops/ansible-ibm-sterling](https://github.com/ibm-sterling-devops/ansible-ibm-sterling).


## Building IBM Sterling CLI images manually

**Prerequisites**

- Podman or Docker installed on your system
- Access to Quay.io (for publishing images)

### Build Steps

1. Clone this repository:
```bash
git clone https://github.com/ibm-sterling-devops/cli.git
```

2. Export variables and login on Quay.io

```bash
export QUAYIO_USERNAME=<your-quay-username>
export QUAYIO_PASSWORD=<your-quay-password>
export QUAYIO_REPO=quay.io/<your-quay-repository>

podman login quay.io -u "$QUAYIO_USERNAME" -p "$QUAYIO_PASSWORD"
```

3. Build your Red Hat UBI9 based image:

Move to the image directory

```bash
cd cli/image
````

For AMD64 architecture:
```bash

podman build --build-arg ARCHITECTURE=amd64 -f Dockerfile.ubi9 -t sterling-cli:1.0.0 .
```

For ARM64 architecture:
```bash
podman build --build-arg ARCHITECTURE=arm64 -f Dockerfile.ubi9 -t sterling-cli:1.0.0 .
```

4. Test Image

To run your container and start a shell session, use:

```bash
podman run -it --rm localhost/sterling-cli:1.0.0
```

### Build and Push Multi-Architecture Image

You can build each architecture on its native machine and then create the manifest list from any machine:

This approach is recommended when:
- You have native hardware for each architecture: faster builds and no emulation overhead
- Cross-platform builds fail or are too slow
- You want to ensure optimal performance for each architecture

Export variables and login on Quay.io

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


## Want to contribute to IBM Sterling - Command Line Interface?
We welcome every Maximo Application Suite users, developers and enthusiasts to contribute to the IBM Sterling - Command Line Interface while fixing code issues and implementing new automated functionalities.

You can contribute to this collection by raising [a new issue](https://github.com/ibm-sterling-devops/cli/issues) with suggestions on how to make our Sterling automation engine even better.


# Contributors

See the list of [contributors](https://github.com/ibm-sterling-devops/cli/contributors) who participated in this project.

# License

This project is licensed under the Eclipse Public License - v 2.0 - see the [LICENSE](LICENSE) file for details

## Troubleshooting

For common issues and solutions, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md).

## Disclaimer

This repository is a community-driven projects and is not officially supported or endorsed by IBM. While members of the community may include IBM employees, this project is independent of IBM's official support channels. Please note that any contributions, issues, or inquiries regarding this repository should be directed to the community maintainers and not to IBM's support teams. We appreciate your understanding and participation in this community-driven initiative.

This code can be used as is. And any feedback will be welcome. We does not make any warranty about the completeness, reliability and accuracy of this code. Any action you take by using this code is strictly at your own risk, and this project will not be liable for any losses and damages in connection with the use of this code.

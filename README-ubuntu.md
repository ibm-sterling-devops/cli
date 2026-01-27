# Building IBM Sterling CLI - Ubuntu 24.04 Based Image

This guide provides instructions for building and publishing the Ubuntu 24.04 based IBM Sterling CLI image.

## Prerequisites
- Podman or Docker installed on your system
- Access to Quay.io (for publishing images)

## Build Steps

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

5. Build your Ubuntu-based image:

**For AMD64 architecture:**
```bash
podman build --build-arg ARCHITECTURE=amd64 -f Dockerfile.ubuntu -t sterling-cli:1.0.0-ubuntu .
```

**For ARM64 architecture:**
```bash
podman build --build-arg ARCHITECTURE=arm64 -f Dockerfile.ubuntu -t sterling-cli:1.0.0-ubuntu .
```

## Test Image

To run your container and start a shell session, use:

```bash
podman run -it --rm localhost/sterling-cli:1.0.0-ubuntu
```

## Publish Image to Quay.io

1. Tag your image with your Quay.io repository name:

```bash
podman tag localhost/sterling-cli:1.0.0-ubuntu quay.io/$QUAYIO_REPO/sterling-cli:1.0.0-ubuntu
```

2. Finally, push your tagged image to Quay.io:

```bash
podman push quay.io/$QUAYIO_REPO/sterling-cli:1.0.0-ubuntu
```

## Back to Main Documentation

For general information about the IBM Sterling CLI and Red Hat UBI9 based images, see the [main README](README.md).
# Troubleshooting

## Red Hat Registry Signature Issues

If you encounter signature verification errors when pulling Red Hat UBI images during multi-architecture builds, you have two options:

### Option 1: Configure Podman to accept unsigned images (Quick fix)

Create or edit `/etc/containers/policy.json`:

```bash
sudo mkdir -p /etc/containers
sudo tee /etc/containers/policy.json > /dev/null <<EOF
{
    "default": [
        {
            "type": "insecureAcceptAnything"
        }
    ],
    "transports": {
        "docker-daemon": {
            "": [{"type": "insecureAcceptAnything"}]
        }
    }
}
EOF
```

### Option 2: Authenticate with Red Hat Registry (Recommended)

```bash
podman login registry.redhat.io
```

Enter your Red Hat account credentials when prompted.
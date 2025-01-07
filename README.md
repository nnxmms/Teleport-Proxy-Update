# Teleport-Proxy-Update

> Date: 07.01.2024

This script can be used to automatically update a Teleport instance to the newest release. It retrieves the latest version and performs the update only if a newer version is available.

## Usage

You can use the script like this:

```bash
curl https://raw.githubusercontent.com/nnxmms/Teleport-Proxy-Update/refs/heads/main/update-teleport-proxy.sh | bash
```

By default, the `EDITION` is set to `oss`, which is the Community edition of Teleport.

## Available Editions

You can specify the desired edition using the `-e` or `--edition` parameter. The following editions are supported:
- oss (default): Community Edition
- cloud: Cloud Edition
- enterprise: Enterprise Edition

### Example usage for a specific edition:

```bash
curl https://raw.githubusercontent.com/nnxmms/Teleport-Proxy-Update/refs/heads/main/update-teleport-proxy.sh | bash -s -- --edition cloud
```

or

```bash
curl https://raw.githubusercontent.com/nnxmms/Teleport-Proxy-Update/refs/heads/main/update-teleport-proxy.sh | bash -s -- -e enterprise
```

## Automate with Cron

To run the script automatically e.g. every day at 03:00 AM, you can use the following cron job:

### Update Teleport Proxy

```bash
0 3 * * * curl https://raw.githubusercontent.com/nnxmms/Teleport-Proxy-Update/refs/heads/main/update-teleport-proxy.sh | bash
```

### Update Teleport Proxy (Specific Edition)

To specify a particular edition (e.g., cloud), modify the cron job as follows:

```bash
0 3 * * * curl https://raw.githubusercontent.com/nnxmms/Teleport-Proxy-Update/refs/heads/main/update-teleport-proxy.sh | bash -s -- --edition cloud
```
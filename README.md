# Teleport-Proxy-Update

> Date: 07.01.2024

This script can be used to automatically update a Teleport instance to the newest release.
It automatically retrieves the latest version and performs the update.

You can use the script like this:

```bash
curl https://raw.githubusercontent.com/nnxmms/Teleport-Proxy-Update/refs/heads/main/update-teleport-proxy.sh | bash
```

By default the `EDITION` is set to `oss` which is the Community edition of Teleport.

To run the script automatically every day at 03:00 AM you can use the following cronjob:

```bash
# Update Teleport Proxy
0 3 * * * curl https://raw.githubusercontent.com/nnxmms/Teleport-Proxy-Update/refs/heads/main/update-teleport-proxy.sh | bash
```
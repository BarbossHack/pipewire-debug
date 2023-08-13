# Pipewire debug Dockerfile

Just a little Makefile/Dockerfile to run the pipewire dev version (following [this tutorial](https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Troubleshooting#running-development-version-of-pipewire)), without having to install any dependency on your host.

## How to use

First, build pipewire dev version

```bash
make build
```

Then, run the pipewire dev version (it will first stop your host pipewire)

```bash
make run
```

When you are done debugging, restart your host pipewire

```bash
make restart
```

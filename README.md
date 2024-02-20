# Container With Nginx and Devpi Server

A Dockerfile image based on registry.access.redhat.com/ubi9/nginx-122 that runs a [devpi](http://doc.devpi.net) server (*a PyPi Cache*) behind Nginx with self signed certificate.

## Usage

Build an image using Dockerfile present in current working directory
```bash
podman build -t <image_name> .
```

Run container instance using image created above by port forwarding container port `8443` to container host's port `8443` 
```bash
podman run -it --rm -p 8443:8443 --name devpi <image_name>

```

### pip

Use a configuration similar to this in your `~/.pip/pip.conf`:

```ini
[global]
index-url = https://<devpi_server_url>/root/pypi/+simple/
```

### setuptools

Use a configuration similar to this in your `~/.pydistutils.cfg`:

```ini
[easy_install]
index_url = https://<devpi_server_url>/root/pypi/+simple/
```
In case, to run devpi-server on localhost system :  `<devpi_server_url>` ~ `localhost` 



zcchen/frps
=============================================

A `frps` docker image based on Alpine Linux.
This image generates `/etc/frps/frps_docker.ini` with environment variables setup.

Example as below:

```
docker run -d --restart unless-stopped --name frps \
    --network=host zcchen/frps
```

Available Environment Variables
---------------------------------------------

| Variable Name | Default Value | Meaning |
| ------------- | ------------- | ------- |
| `BIND_ADDRESS` | `0.0.0.0` | available addresses for frps |
| `BIND_PORT_TCP` | `7000`  | the frps port to make TCP / KCP hole |
| `BIND_PORT_UDP` |         | the frps port to make UDP hole |
| `VHOST_HTTP_PORT` |       | the frps port for HTTP vhost port, able to be same as `BIND_PORT_TCP` |
| ------------- | ------------- | ------- |
| `DASHBOARD_ADDRESS` | `0.0.0.0` | available addresses for frps dashboard |
| `DASHBOARD_PORT` |         | the frps dashboard port |
| `DASHBOARD_USER` | `admin` | the frps dashboard user |
| `DASHBOARD_PASSWORD` | `admin` | the frps dashboard password |
| ------------- | ------------- | ------- |
| `AUTH_TOKEN`  |       | the auth token used with frps. frpc should keep it same with frps. |
| ------------- | ------------- | ------- |
| `APPEND_CONFIG_FILE`  |       | the config file which appending for this template. |

Github Repository
---------------------------------------------

For more details, please check the following github repository:
[https://github.com/zcchen/dockers](https://github.com/zcchen/dockers)

zcchen/frps
=============================================

A `frps` docker image based on Alpine Linux.
This image generates `/etc/frp/frps_docker.ini` with environment variables setup.

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
| `BIND_PORT_TCP` | `7000`  | the frps port to make TCP / KCP / HTTP / HTTPS hole |
| `BIND_PORT_UDP` |         | the frps port to make UDP hole |

| Variable Name | Default Value | Meaning |
| ------------- | ------------- | ------- |
| `DASHBOARD_ADDRESS` | `0.0.0.0` | available addresses for frps dashboard |
| `DASHBOARD_PORT` |         | the frps dashboard port |
| `DASHBOARD_USER` | `admin` | the frps dashboard user |
| `DASHBOARD_USER_FILE` |    | the secret file for frps dashboard user |
| `DASHBOARD_PASSWORD` | `admin` | the frps dashboard password |
| `DASHBOARD_PASSWORD_FILE` |    | the secret file for frps dashboard password |

| Variable Name | Default Value | Meaning |
| ------------- | ------------- | ------- |
| `AUTH_TOKEN`  |       | the auth token used with frps. frpc should keep it same with frps. |
| `AUTH_TOKEN_FILE`  |       | the secret file for auth token used with frps. |

| Variable Name | Default Value | Meaning |
| ------------- | ------------- | ------- |
| `APPEND_CONFIG_FILES`  |       | the config files which appending for this template, separated by comma `,` or space chars ` `, e.g.: `a.ini,b.ini`|

Github Repository
---------------------------------------------

For more details, please check the following github repository:
[https://github.com/zcchen/dockers](https://github.com/zcchen/dockers)

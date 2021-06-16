zcchen/frpc
=============================================

A `frpc` docker image based on Alpine Linux.
This image generates `/etc/frp/frpc_docker.ini` with environment variables setup.

Example as below:

```
docker run -d --restart unless-stopped --name frps \
    -e SERVER_ADDRESS=127.0.0.1 \
    --network=host zcchen/frpc
```

Available Environment Variables
---------------------------------------------

| Variable Name | Default Value | Meaning |
| ------------- | ------------- | ------- |
| `SERVER_ADDRESS` | `0.0.0.0` | the frps server addresses |
| `SERVER_PORT` | `7000` | the frps server port |
| `PROTOCOL` | `tcp` | the connection protocol between frpc and frps |
| `AUTH_TOKEN`  |       | the auth token used with frp. frpc should keep it same with frps. |
| `AUTH_TOKEN_FILE`  |  | the secret file for auth token used with frps. |
| `APPEND_CONFIG_FILES`  |       | the config files which appending for this template, separated by comma `,` or space chars ` `, e.g.: `a.ini,b.ini`|

Github Repository
---------------------------------------------

For more details, please check the following github repository:
[https://github.com/zcchen/dockers](https://github.com/zcchen/dockers)

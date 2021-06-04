zcchen/privoxy
=============================================

A `privoxy` docker image based on Alphine Linux.
This image generates `/etc/privoxy/config` with environment variables setup.

Example as below:

```
docker run -d --restart unless-stopped --name privoxy \
    -e LISTEN_ADDRESS_IPV4="0.0.0.0" \
    -p 8118:8118 zcchen/privoxy
```

Available Environment Variables
---------------------------------------------

| Variable Name | Default Value | Meaning |
| ------------- | ------------- | ------- |
| `LISTEN_ADDRESS_IPV4` | `127.0.0.1` | available IPv4 addresses for privoxy |
| `LISTEN_ADDRESS_IPV6` | `[::1]` | available IPv6 addresses for privoxy |
| `LISTEN_PORT` | `8118` | the privoxy service port |
| `TARGET_PATTERN` | `/` | the target pattern for privoxy to port |
| `HTTP_PARENT` | `.` | the upstream HTTP proxy |
| `SOCKS_PROXY` |     | the upstream SOCKS proxy address |
| `SOCKS_METHOD` |     | the upstream SOCKS proxy method |

Github Repository
---------------------------------------------

For more details, please check the following github repository:
[https://github.com/zcchen/dockers][https://github.com/zcchen/dockers]

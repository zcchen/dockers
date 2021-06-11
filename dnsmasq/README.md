zcchen/dnsmasq
=============================================

A `dnsmasq` docker image based on Alphine Linux.
This image provides `/scripts.d` volume for users to add update scripts

Example as below:

```
docker run -d --restart unless-stopped --name dnsmasq \
    -v /tmp/:/scripts.d/:ro \
    -p 53:53/udp zcchen/dnsmasq
```

Available Environment Variables
---------------------------------------------

| Variable Name | Default Value | Meaning |
| ------------- | ------------- | ------- |
| `UPDATE_INTERVAL` | `3600 * 24` | The interval time to execute the update scripts |

Github Repository
---------------------------------------------

For more details, please check the following github repository:
[https://github.com/zcchen/dockers][https://github.com/zcchen/dockers]

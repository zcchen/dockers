FROM alpine

RUN apk --no-cache add \
        git bash wget dnsmasq

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /scripts.d

EXPOSE 53

ENTRYPOINT [ "bash", "/entrypoint.sh" ]

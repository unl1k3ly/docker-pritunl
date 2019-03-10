FROM ubuntu:16.04

# https://api.github.com/repos/pritunl/pritunl/tags
ARG PRITUNL_VERSION=""
ENV PRITUNL_VERSION="latest"

ARG MONGODB_VERSION="*"
ENV MONGODB_VERSION=${MONGODB_VERSION}

ARG WEBGUI_PORT="9700"
ENV WEBGUI_PORT=${WEBGUI_PORT}

LABEL MAINTAINER="Vini <vini@contentsecurity.com.au>"

COPY --chown=root:root ["docker-install.sh", "/root"]

RUN bash /root/docker-install.sh

ADD start-pritunl /bin/start-pritunl


EXPOSE 443
EXPOSE 1337/udp
EXPOSE ${WEBGUI_PORT}

ENTRYPOINT ["/bin/start-pritunl"]

CMD ["/usr/bin/tail", "-f","/var/log/pritunl.log"]

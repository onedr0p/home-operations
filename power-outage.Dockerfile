FROM python:3.9.0-slim

ARG TARGETPLATFORM

ENV \
  DEBCONF_NONINTERACTIVE_SEEN=true \
  DEBIAN_FRONTEND=noninteractive \
  TINI_VERSION=0.19.0 \
  WEBHOOK_VERSION=2.7.0

# Install OS deps
RUN \
  set -eux \
  && \
  apt-get -qq update \
  && \
  apt-get -qq install -y --no-install-recommends --no-install-suggests \
    ca-certificates \
    curl \
    jq \
    gnupg2 \
    locales \
    tzdata \
    openssh-client \
    sshpass \
    lftp \
  && locale-gen en_US.UTF-8 \
  && curl -fsSL -o /sbin/tini "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-amd64" \
  && curl -fsSL -o /tini.asc "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini-amd64.asc" \
  && gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
  && gpg --batch --verify /tini.asc /sbin/tini \
  && chmod +x /sbin/tini \
  && gpgconf --kill all \
  && \
  curl -fsSL -o /tmp/webhook.tar.gz \
    "https://github.com/adnanh/webhook/releases/download/${WEBHOOK_VERSION}/webhook-linux-amd64.tar.gz" \
  && tar ixzf /tmp/webhook.tar.gz -C /usr/local/bin --strip-components 1 \
  && \
  pip3 install --no-cache-dir -U \
    ansible>=2.10.0 \
  && \
  apt-get remove -y \
    gnupg2 curl jq \
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt-get autoremove -y \
  && apt-get clean \
  && \
  rm -rf \
    /tini.asc \
    /tmp/webhook.tar.gz \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/cache/apt/* \
    /var/tmp/*

COPY ./power-outage/entrypoint.sh /

WORKDIR /app

COPY ./ansible.cfg .
COPY ./ansible/inventory ./ansible/inventory
COPY ./ansible/playbooks/power-outage.yml ./ansible/playbooks/power-outage.yml

COPY ./power-outage/hooks.json .
COPY ./power-outage/power-outage.sh .

# RUN ansible-playbook \
#   --private-key /config/id_rsa \
#   -i ./ansible/inventory/cluster/hosts.yml \
#   ./ansible/playbooks/power-outage.yml

VOLUME [ "/config" ]

EXPOSE 9000

ENTRYPOINT [ "/sbin/tini", "--" ]
CMD [ "/entrypoint.sh" ]

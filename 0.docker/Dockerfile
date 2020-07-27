ARG ALPINE_VERSION=3.11
FROM alpine:${ALPINE_VERSION}

# packages version
ARG PACKER_VERSION=1.6.0


# PARAMETERS
ARG PACKER_URL="https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"

# set workdir
RUN mkdir /packer
WORKDIR /packer

# install temporary dependencies
RUN apk add --no-cache --virtual \
  .build-deps \
  build-base \
  g++ \
  gettext \
  libxml2-dev \
  libffi-dev \
  openssl-dev \
  curl \
  jq \
  python3 \
  py3-crcmod \
  openssh-client \
  gnupg \
  zip \
  ca-certificates \
  bash \
  git \
  make \
  ansible \
  ansible-lint

RUN apk add --no-cache --update \
  python3 \
  ruby-dev \
  ruby-full

RUN gem install \
  inspec \
  inspec-bin

RUN curl -sSL ${PACKER_URL} \
    -o /tmp/packer.zip && \
    unzip /tmp/packer.zip -d /usr/bin && \
    rm /tmp/packer.zip

# Cleaning up temporary resources
RUN apk del zip && \
    rm -rf /var/cache/apk/*

CMD ["bash"]
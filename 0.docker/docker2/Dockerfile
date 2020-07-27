FROM ubuntu:18.04

# packages version
ARG PACKER_VERSION=1.6.0


# PARAMETERS
ARG PACKER_URL="https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"

# set workdir
WORKDIR /tmp

RUN apt-get update -y

RUN apt-get install -y \
    python3 \
    python3-pip \
    curl \
    zip \
    ansible \
    openssh-client \
    git \
    make \
    ruby-dev \
    ruby-full

RUN gem install \
  inspec \
  inspec-bin

RUN curl -sSL ${PACKER_URL} \
    -o /tmp/packer.zip && \
    unzip /tmp/packer.zip -d /usr/bin && \
    rm /tmp/packer.zip

CMD ["bash"]
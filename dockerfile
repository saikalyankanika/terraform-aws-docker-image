from alpine:latest
USER root
RUN apk update && apk upgrade --no-cache
RUN apk add --no-cache bash \
     bash-completion \
     less \
     groff \
     aws-cli \ 
     ca-certificates \ 
     curl \
     jq \
     git \ 
     openssh \ 
     openssl \ 
     py-pip \ 
     python3 \ 
     py-setuptools \ 
     unzip \
     wget \
     vim 

ARG PRODUCT
ARG VERSION

#fetching the terraform binary from the hashicorp website
RUN apk add --update --virtual .deps --no-cache gnupg && \
     cd /tmp && \
     wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_linux_amd64.zip && \
     wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS && \
     wget https://releases.hashicorp.com/${PRODUCT}/${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig && \
     wget -qO- https://www.hashicorp.com/.well-known/pgp-key.txt | gpg --import && \
     gpg --verify ${PRODUCT}_${VERSION}_SHA256SUMS.sig ${PRODUCT}_${VERSION}_SHA256SUMS && \
     grep ${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS | sha256sum -c && \
     unzip /tmp/${PRODUCT}_${VERSION}_linux_amd64.zip -d /tmp && \
     mv /tmp/${PRODUCT} /usr/local/bin/${PRODUCT} && \
     rm -f /tmp/${PRODUCT}_${VERSION}_linux_amd64.zip ${PRODUCT}_${VERSION}_SHA256SUMS ${VERSION}/${PRODUCT}_${VERSION}_SHA256SUMS.sig && \
     apk del .deps

#packages for boto3 and all so that we can connect to aws using boto3 sdk
RUN pip3 install --break-system-package backports.functools-lru-cache \
     beautifulsoup4 \
     boto3 \
     botocore \
     certifi \
     requests \
     requests-aws4auth \
     urllib3
# Install Python packages globally using --break-system-packages
RUN pip3 install --upgrade pip --break-system-packages && \ 
     pip3 install --upgrade setuptools --break-system-packages && \ 
     pip3 install checkov --break-system-packages

ENV AWS_SHARED_CREDENTIALS_FILE=/root/.aws/credentials
RUN mkdir -p /root/.aws
WORKDIR /root

CMD ["/bin/bash"]
 
 

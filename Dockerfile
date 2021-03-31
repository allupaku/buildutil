FROM alpine:3.13.3
MAINTAINER althafm@outlook.com
RUN apk --update add --virtual .build-deps python3-dev libffi-dev openssl-dev build-base curl
RUN apk update && apk add --update python3 py3-pip  ca-certificates git openssh-client \
openssl py3-cryptography
RUN pip3 install --upgrade pip && pip3 install ansible
RUN curl -LO https://get.helm.sh/helm-v3.5.3-linux-amd64.tar.gz \
&& tar -xvf helm-v3.5.3-linux-amd64.tar.gz \
&& mv linux-amd64/helm /bin/helm \
&& chmod +x /bin/helm

RUN curl -LO https://dl.k8s.io/release/v1.20.0/bin/linux/amd64/kubectl.sha256 \
&& curl -LO https://dl.k8s.io/release/v1.20.0/bin/linux/amd64/kubectl #\
&& echo "`cat kubectl.sha256`  kubectl" | sha256sum -c \
&& chmod +x kubectl \
&& mv kubectl /bin/kubectl \
&& pip install kubernetes==11.0.0 \
&& pip install openshift==0.11.2

RUN curl -LO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-334.0.0-linux-x86_64.tar.gz &&\
tar -xf google-cloud-sdk-334.0.0-linux-x86_64.tar.gz &&\
mv google-cloud-sdk /usr/bin/google-cloud-sdk

ENV PATH="/usr/bin/google-cloud-sdk/bin:${PATH}"

CMD "ansible"




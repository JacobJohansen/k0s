FROM alpine:3.12

RUN apk add bash coreutils findutils iptables curl

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.19.0/bin/linux/amd64/kubectl \
       && chmod +x ./kubectl \
       && mv ./kubectl /usr/local/bin/kubectl
ENV KUBECONFIG=/var/lib/k0s/pki/admin.conf

ADD docker-entrypoint.sh /entrypoint.sh
ADD ./k0s /usr/local/bin/k0s 
ENTRYPOINT [ "/bin/sh", "/entrypoint.sh" ]

CMD ["k0s", "server", "--enable-worker"]
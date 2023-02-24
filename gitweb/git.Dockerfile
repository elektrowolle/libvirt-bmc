FROM registry.fedoraproject.org/fedora
RUN yum install -y git gitweb httpd

COPY gitweb.conf /etc/gitweb.conf
COPY gitweb.httpd.conf /etc/httpd/conf.d/gitweb.conf
COPY entrypoint.sh entrypoint.sh


EXPOSE 80
ENV GIT_BASE_URL "Set-GIT_BASE_URL-env-to-the-vm-address/git"

ENTRYPOINT /bin/sh ./entrypoint.sh $@

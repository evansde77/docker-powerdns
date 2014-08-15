FROM debian:latest
MAINTAINER Tim Herman <tim@belg.be>

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

# Basic Requirements
RUN apt-get -y install pdns-server pdns-backend-mysql mysql-client

EXPOSE 53
EXPOSE 80

add /sql /sql
add /scripts /scripts
run chmod +x /scripts/*

ENTRYPOINT ["/scripts/entrypoint.sh"]
CMD ["/bin/bash", "/scripts/start.sh"]

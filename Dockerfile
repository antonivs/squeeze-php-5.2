FROM stackbrew/debian:squeeze
MAINTAINER Anton van Straaten <anton@appsolutions.com>

# Timeout issues with http.debian.net
RUN sed -i.bak 's/http.debian.net/debian.gtisc.gatech.edu/' /etc/apt/sources.list

ADD lenny.list /etc/apt/sources.list.d/
ADD lenny-php /etc/apt/preferences.d/

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y libapache2-mod-php5 php5-common php5-curl php5-gd php5-mcrypt php5-mysql php5-cli php5-mhash php5-xsl php5-imap php5-xmlrpc php5-sqlite


FROM stackbrew/debian:squeeze
MAINTAINER Anton van Straaten <anton@appsolutions.com>

# Timeout issues with http.debian.net
RUN sed -i.bak 's/http.debian.net/debian.gtisc.gatech.edu/' /etc/apt/sources.list

# Retrieve PHP 5.2 from Lenny
ADD lenny.list /etc/apt/sources.list.d/
ADD lenny-php /etc/apt/preferences.d/

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq apt-utils && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq apache2 libapache2-mod-php5 php5-common php5-curl php5-gd php5-mcrypt php5-mysql php5-cli php5-mhash php5-xsl php5-imap php5-xmlrpc php5-sqlite && \
  rm -rf /var/lib/apt/lists/*

# from tutum/docker-php: 
# Other packages: curl, php-pear, php-apc
# RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]


# pma,php-fpm,7.0,apache,opcache
# WP
# 14/07/2021

# --------------- DÉBUT COUCHE OS -------------------
FROM debian:buster-slim
# --------------- FIN COUCHE OS ---------------------


# MÉTADONNÉES DE L'IMAGE
LABEL version="1.0" maintainer="Alexandre Domont"


# VARIABLES TEMPORAIRES
ARG APT_FLAGS="-q -y"
ARG DOCUMENTROOT="/var/www/html"


# --------------- DÉBUT COUCHE A SUP ---------------
RUN apt-get update -y && \
    apt-get install ${APT_FLAGS} vim wget && rm -rf /var/lib/apt/lists/*

# --------------- FIN COUCHE A SUP -----------------


# --------------- DÉBUT COUCHE A SUP ---------------
RUN apt-get update -y && \
    apt-get install ${APT_FLAGS} gnupg ca-certificates apt-transport-https lsb-release && \
    wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - &&\
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list &&\
    rm -rf /var/lib/apt/lists/*

# --------------- FIN COUCHE A SUP -----------------

# --------------- DÉBUT COUCHE APACHE ---------------
RUN apt-get update -y && \
    apt-get install ${APT_FLAGS} apache2 && rm -rf /var/lib/apt/lists/*

RUN a2enmod alias proxy proxy_fcgi ssl rewrite
# --------------- FIN COUCHE APACHE -----------------


# --------------- DÉBUT COUCHE PHP ---------------
RUN apt-get update -y && \
    apt-get install ${APT_FLAGS} php7.0-curl php7.0-gd php7.0-mbstring php7.0-xml php7.0-xmlrpc php7.0-soap php7.0-intl php7.0-zip && rm -rf /var/lib/apt/lists/*
# --------------- FIN COUCHE PHP ---------------


# --------------- DÉBUT COUCHE MYSQL ----------------
RUN apt-get update -y && apt-get install ${APT_FLAGS} mariadb-server && rm -rf /var/lib/apt/lists/*

# --------------- FIN COUCHE MYSQL ------------------

# --------------- DÉBUT COUCHE PHP ------------------
RUN apt-get update -y && apt-get install ${APT_FLAGS} \
    php7.0-mysql php7.0-fpm &&\ 
    apt-get autoclean -y && rm -rf /var/lib/apt/lists/*
# --------------- FIN COUCHE PHP --------------------

# --------------- DÉBUT COUCHE PHPMyAdmin ------------------
# README https://www.digitalocean.com/community/tutorials/how-to-install-phpmyadmin-from-source-debian-10
WORKDIR /usr/share
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.1/phpMyAdmin-5.1.1-all-languages.tar.gz &&\
	tar xvf phpMyAdmin-5.1.1-all-languages.tar.gz &&\
	mv phpMyAdmin-5.1.1-all-languages phpmyadmin &&\
	mkdir -p /var/lib/phpmyadmin/tmp &&\
	chown -R www-data:www-data /var/lib/phpmyadmin &&\
	rm -rd phpMyAdmin-5.1.1-all-languages.tar.gz
	
# --------------- FIN COUCHE SSH --------------------
RUN apt-get update -y && \
    apt-get install ${APT_FLAGS} ssh &&\
    rm -rf /var/lib/apt/lists/*
# --------------- FIN COUCHE A SSH -----------------

# OUVERTURE DU PORT HTTP
EXPOSE 80 443

# DEFINITION DES VOLUMES  ------------------
VOLUME /var/lib/mysql
VOLUME /var/www/html
VOLUME /etc/apache2/sites-available/
VOLUME /usr/share/phpmyadmin
VOLUME /var/lib/phpmyadmin

# RÉPERTOIRE DE TRAVAIL
WORKDIR  ${DOCUMENTROOT}

# DÉMARRAGE DES SERVICES LORS DE L'EXÉCUTION DE L'IMAGE
COPY docker-entrypoint.sh /usr/local/bin/ 
ENTRYPOINT ["docker-entrypoint.sh"] 


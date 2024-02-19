RUN apt update && apt install libapache2-mod-xsendfile -y
RUN a2enmod xsendfile

RUN sed -i '/DocumentRoot/a \        Alias \/sub \/var\/www\/html' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i '/DocumentRoot/a \        XSendFilePath \/var\/www' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i '/DocumentRoot/a \        XSendFilePath \/var\/iliasdata' /etc/apache2/sites-enabled/000-default.conf
RUN ln -s /var/www/html /var/www/html/sub2

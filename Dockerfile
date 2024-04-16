FROM nginx:stable-alpine

VOLUME /tmp

#Instalacion de web app sobre nginx server
RUN rm -rf /usr/share/nginx/html/*
COPY nginx.conf /etc/nginx/nginx.conf
COPY dist/billingApp /usr/share/nginx/html
COPY mime.types /etc/nginx/mime.types

#Instalacion OpenJDK 17
RUN apk --no-cache add openjdk17-jre

#Variables de JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-17-openjdk
ENV PATH $JAVA_HOME/bin:$PATH

#Verificacion de instalacion
RUN java -version

#Microservices JAVA
ENV JAVA_OPTS=""
ARG JAR_FILE
ADD ${JAR_FILE} app.jar

#Scripts iniciales
COPY appshell.sh appshell.sh

#Puertos expuestos
EXPOSE 80 7080

ENTRYPOINT [ "sh", "/appshell.sh" ]



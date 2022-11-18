FROM emqx/emqx-ee:latest
USER root
WORKDIR /opt/emqx/
#COPY emqx.conf /opt/emqx/etc/
#RUN chmod 777 /opt/emqx/etc/emqx.conf
COPY emqx.pem etc/certs/
COPY emqx.key etc/certs/
COPY ca.pem etc/certs/
COPY emqx_bridge_kafka.conf /opt/emqx/etc/plugins/
COPY emqx_auth_mnesia.conf /opt/emqx/etc/plugins/
RUN chmod 777 /opt/emqx/etc/plugins/emqx_auth_mnesia.conf
RUN chmod 777 /opt/emqx/etc/plugins/emqx_bridge_kafka.conf
EXPOSE 1883
EXPOSE 8883
EXPOSE 8081
EXPOSE 8083
EXPOSE 8084
EXPOSE 18083


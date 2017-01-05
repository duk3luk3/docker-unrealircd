FROM ubuntu:trusty
ENV LC_ALL C
ENV UNREAL_VERSION="4.0.1"
ENV ANOPE_VERSION="2.0.2"
ENV MOTD="Welcome to Forged Alliance Forever chat"
ENV RULES=""
ENV TERM="vt100"
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
 wget build-essential curl cmake file expect libssl-dev libmysqlclient-dev mysql-client-5.6
RUN groupadd -r unreal && useradd -r -g unreal unreal
RUN mkdir -p /home/unreal
RUN chown unreal:unreal /home/unreal
USER unreal
ENV HOME /home/unreal
WORKDIR /home/unreal
ADD deploy-unrealirc.sh /usr/bin/deploy-unrealirc
ADD secrets.sh /home/unreal/secrets.sh
ADD config /home/unreal/config
ADD anope-make.expect /home/unreal/anope-make.expect
COPY deploy-anope /usr/bin/deploy-anope
USER root
RUN chmod +x /usr/bin/deploy-unrealirc
RUN chmod +x /usr/bin/deploy-anope
USER unreal

RUN wget https://www.unrealircd.org/unrealircd4/unrealircd-4.0.1.tar.gz
RUN tar -zxvf unrealircd-$UNREAL_VERSION.tar.gz
WORKDIR unrealircd-$UNREAL_VERSION
ADD config.settings ./config.settings
RUN ./Config
RUN make
RUN make install
RUN echo $MOTD > ircd.motd
RUN echo $RULES > ircd.rules

WORKDIR /home/unreal
RUN deploy-anope
ADD server.cert.pem /home/unreal/server.cert.pem
ADD server.key.pem /home/unreal/server.key.pem
RUN cp /home/unreal/server.cert.pem /home/unreal/unrealircd/conf/ssl/server.cert.pem
RUN cp /home/unreal/server.key.pem /home/unreal/unrealircd/conf/ssl/server.key.pem
ADD unreal.conf /home/unreal/unreal.conf
ADD services.conf /home/unreal/services.conf
RUN ./secrets.sh
RUN cp /home/unreal/unreal.conf /home/unreal/unrealircd/conf/unrealircd.conf
RUN cp /home/unreal/services.conf /home/unreal/unrealircd/services/conf/services.conf
ADD run_anope.sh /home/unreal/run_anope.sh
USER root
RUN chmod +x /home/unreal/run_anope.sh
USER unreal
CMD /home/unreal/unrealircd/unrealircd start && /home/unreal/run_anope.sh

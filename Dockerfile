FROM ubuntu:15.10
ENV LC_ALL C
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
 wget build-essential curl cmake file expect
RUN groupadd -r unreal && useradd -r -g unreal unreal
RUN mkdir -p /home/unreal
RUN chown unreal:unreal /home/unreal
USER unreal
ENV HOME /home/unreal
WORKDIR /home/unreal
ADD unreal.conf /home/unreal/unreal.conf
ADD deploy-unrealirc.sh /usr/bin/deploy-unrealirc
ADD config /home/unreal/config
ADD anope-make.expect /home/unreal/anope-make.expect
COPY deploy-anope /usr/bin/deploy-anope
USER root
RUN chmod +x /usr/bin/deploy-unrealirc
RUN chmod +x /usr/bin/deploy-anope
USER unreal
RUN deploy-unrealirc
WORKDIR /home/unreal
RUN deploy-anope
CMD /bin/bash -c source /config; /tmp/Unreal$UNREAL_VERSION/unreal start

FROM jetbrains/teamcity-minimal-agent:latest

MAINTAINER Kateryna Shlyakhovetska <shkate@jetbrains.com>

LABEL dockerImage.teamcity.version="latest" \
      dockerImage.teamcity.buildNumber="latest"

RUN apt-get update && \
    apt-get install -y software-properties-common && add-apt-repository ppa:openjdk-r/ppa && apt-get update && \
    apt-get install -y git mercurial openjdk-8-jdk apt-transport-https ca-certificates && \
    apt-get install -y mysql-client && \
    apt-get install -y python python-pip && \
    apt-get install -y nodejs npm && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    pip install awscli && \
    \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
    echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list && \
    \
    apt-cache policy docker-engine && \
    apt-get update && \
    apt-get install -y docker-engine=1.13.0-0~ubuntu-xenial && \
    \
    apt-get clean all && \
    \
    usermod -aG docker buildagent

COPY run-docker.sh /services/run-docker.sh



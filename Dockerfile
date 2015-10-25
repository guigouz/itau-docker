FROM ubuntu:14.04

RUN apt-get update && apt-get install -y xterm

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN apt-get install -y firefox

RUN apt-get install -y curl libnss3-tools

RUN curl -o /tmp/warsaw_setup_64.deb 'https://guardiao.itau.com.br/warsaw/warsaw_setup_64.deb'

RUN dpkg -i /tmp/warsaw_setup_64.deb

ENV DISPLAY :0
RUN echo 'deb http://archive.ubuntu.com/ubuntu trusty multiverse'  >> /etc/apt/sources.list && \
 echo 'deb http://archive.ubuntu.com/ubuntu trusty-updates multiverse' >> /etc/apt/sources.list && apt-get update

RUN echo 'ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true' | sudo debconf-set-selections

RUN apt-get install -y libfreetype6 libfreetype6-dev libfontconfig ttf-mscorefonts-installer

USER developer
ENV HOME /home/developer

CMD sudo /etc/init.d/warsaw start && /usr/bin/firefox -no-remote
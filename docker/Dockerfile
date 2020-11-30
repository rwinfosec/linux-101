FROM ubuntu:latest

USER root

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y curl htop man man-db unzip vim wget openssh-server sudo ufw && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /run/sshd
RUN useradd -rm -d /home/gumby -s /bin/bash -g root -G sudo -u 1001 gumby && \
    echo 'root:root' | chpasswd && \
    echo 'gumby:pokey' | chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -i -e '$aAllowUsers gumby root' /etc/ssh/sshd_config

COPY docker/sourcefiles/ryanrocks.txt /home/gumby
COPY docker/sourcefiles/tacos.txt /home/gumby
COPY docker/sourcefiles/pcap.txt /home/gumby

CMD ["/usr/sbin/sshd", "-D"]
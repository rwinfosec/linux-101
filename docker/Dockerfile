FROM ubuntu:latest

USER root

#Set TimeZone
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install required packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y build-essential && \
    apt-get install -y htop man man-db vim openssh-server sudo ufw && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -rm -d /home/gumby -s /bin/bash -g root -G sudo -u 1001 gumby && \
    echo 'root:root' |chpasswd && \
    echo 'gumby:pokey' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config &&
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config &&
    sed -i -e '$aAllowUsers gumby root' /etc/ssh/sshd_config

COPY sourcefiles/ryanrocks.txt /home/gumby
COPY sourcefiles/tacos.txt /home/gumby
COPY sourcefiles/pcap.txt /home/gumby

CMD ["/usr/sbin/sshd", "-D"]

USER gumby
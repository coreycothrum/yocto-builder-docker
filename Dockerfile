FROM ghcr.io/siemens/kas/kas:3.0.2

################################################################################
# OS setup #####################################################################
################################################################################
RUN apt-get    update      && \
    apt-get -y install        \
               bash           \
               qemu-system    \
               sudo        && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install kas --upgrade

################################################################################
# user setup ###################################################################
################################################################################
ENV USERNAME user

ARG host_uid=1001
ARG host_gid=1001

RUN addgroup -gid $host_gid                                               $USERNAME && \
    adduser  -gid $host_gid -uid $host_uid --disabled-password --gecos '' $USERNAME && \
    usermod  -aG  sudo                                                    $USERNAME

#TODO sudo ALL isn't great, but not sure how to handle sudo for yocto-native stuff
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL'                   >> /etc/sudoers
#RUN echo '%sudo ALL=(ALL) NOPASSWD: /usr/sbin/cryptsetup' >> /etc/sudoers
#RUN echo '%sudo ALL=(ALL) NOPASSWD: /usr/sbin/dmsetup'    >> /etc/sudoers
#RUN echo '%sudo ALL=(ALL) NOPASSWD: /usr/sbin/losetup'    >> /etc/sudoers

USER $USERNAME

################################################################################
# execute / command(s) #########################################################
################################################################################

ENTRYPOINT '/bin/bash'
CMD        ['']

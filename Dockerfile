FROM kasproject/kas

################################################################################
# OS setup #####################################################################
################################################################################
RUN apt-get    update      && \
    apt-get -y upgrade     && \
    apt-get -y install        \
      bash                    \
      qemu-system             \
      sudo                 && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install kas --upgrade

################################################################################
RUN git clone https://github.com/melloyawn/melloVIM.git /tmp/.vim_tmp            && \
                                                        /tmp/.vim_tmp/install.sh && \
                                                 rm -fr /tmp/.vim_tmp

RUN git clone https://github.com/kergoth/vim-bitbake.git /etc/vim/pack/lang/start/bitbake

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
# ENV setup ####################################################################
################################################################################
arg work_dir="/yocto_workspace"

ENV      YOCTO_WORKDIR $work_dir
WORKDIR $YOCTO_WORKDIR

################################################################################
# execute / command(s) #########################################################
################################################################################
ENTRYPOINT '/bin/bash'
CMD        ['']

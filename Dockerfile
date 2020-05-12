FROM jamesnetherton/docker-atom-editor

USER root

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y openssh-server x11-apps xauth xserver-xorg-core rox-filer openssh-server xserver-xephyr xdm fluxbox xvfb sudo

RUN sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config
RUN sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess
RUN echo X11Forwarding yes >> /etc/ssh/ssh_config
RUN echo X11UseLocalhost no >> /etc/ssh/sshd_config

# Fix PAM login issue with sshd
RUN sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

EXPOSE 22

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/bin/bash", "/start.sh"]

FROM jamesnetherton/docker-atom-editor

USER root

ENV DEBIAN_FRONTEND noninteractive
ENV PUID 1000
ENV PGID 1000

COPY start.sh /start.sh
RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y openssh-server x11-apps xauth xserver-xorg-core rox-filer openssh-server xserver-xephyr xdm fluxbox xvfb sudo && \
	sed -i 's/DisplayManager.requestPort/!DisplayManager.requestPort/g' /etc/X11/xdm/xdm-config && \
	sed -i '/#any host/c\*' /etc/X11/xdm/Xaccess && \
	echo X11Forwarding yes >> /etc/ssh/ssh_config && \
	echo X11UseLocalhost no >> /etc/ssh/sshd_config && \
	sed -i 's/session    required     pam_loginuid.so/#session    required     pam_loginuid.so/g' /etc/pam.d/sshd && \
	localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || : && \
	chmod +x /start.sh

EXPOSE 22

CMD ["/bin/bash", "/start.sh"]

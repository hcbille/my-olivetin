FROM jamesread/olivetin

#From the parent image
#EXPOSE 1337/tcp 
#VOLUME /config
#ENTRYPOINT [ "/usr/bin/OliveTin" ]

#It runs microdnf
USER root

RUN microdnf install -y --nodocs --noplugins --setopt=keepcache=0 --setopt=install_weak_deps=0 \
            python3 \
            python3-pip \
            ca-certificates \
            vim \
            wget \
            yum \
        && microdnf clean all

RUN python3 -m pip install --no-cache-dir --force-reinstall audiobook-dl

RUN yum localinstall -y --nogpgcheck https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
    yum install -y ffmpeg &&\
    yum clean all

RUN wget -O /config/config.yaml https://raw.githubusercontent.com/hcbille/my-olivetin/master/config.yaml   && \
mkdir /audiobook/ && \
chmod 777 /audiobook/


USER olivetin
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
        && microdnf clean all

RUN python3 -m pip install --no-cache-dir --force-reinstall audiobook-dl 

RUN curl --create-dirs 1 --output-dir /config/ https://raw.githubusercontent.com/hcbille/my-olivetin/master/config.yaml

USER olivetin

VOLUME [ "/audiobook" ]
FROM ubuntu:focal

LABEL maintainer="Martin Bjeldbak Madsen <me@martinbjeldbak.com>"


ENV ACESTREAM_VERSION="3.1.75rc4_ubuntu_18.04_x86_64_py3.8"

RUN apt-get update
RUN apt-get install --no-install-recommends -y \
        wget \
        python3.8 \
        python3.8-dev \
        libpython3.8 \
        libssl-dev \
        swig \
        gcc \
        python3-pip \
        python-setuptools \
        net-tools

RUN pip install lxml pycryptodome apsw pynacl


RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/* 
RUN wget "http://download.acestream.media/linux/acestream_${ACESTREAM_VERSION}.tar.gz" && \
      mkdir acestream && \
      tar zxf "acestream_${ACESTREAM_VERSION}.tar.gz" -C acestream && \
      mv acestream /opt/acestream

RUN ls /opt/acestream

EXPOSE 6878
#CMD ["/bin/bash"]
CMD ["/opt/acestream/start-engine", "--client-console"]

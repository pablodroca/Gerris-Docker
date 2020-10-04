FROM debian:9
ARG DEFAULT_USER=root
ARG DEFAULT_UID=0

ENV DEBIAN_FRONTEND=noninteractive
ENV DEFAULT_USER=${DEFAULT_USER}
RUN apt update && \
    ln -fs /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime && \
    apt -yq install tzdata && \
    apt -yq install libglib2.0-dev libnetpbm10-dev m4 libproj-dev libgsl0-dev libnetcdf-dev libode-dev libfftw3-dev libhypre-dev libgtkglext1-dev libstartup-notification0-dev ffmpeg \
        autoconf libtool-bin automake git python-dev wget vim \
        libosmesa6-dev libftgl-dev bc iptables
ENV DEFAULT_UID=${DEFAULT_UID}

RUN useradd -r -u ${DEFAULT_UID} -s /bin/bash ${DEFAULT_USER}

WORKDIR /home/gerris
RUN git clone https://github.com/pablodroca/Gerris-ControllerModule.git
RUN cd Gerris-ControllerModule && \
    cd gts-stable && \
    sh autogen.sh && automake --add-missing && \
    ./configure && \
    make -j4 && make -j4 install
RUN cd Gerris-ControllerModule && \
    cd gerris-stable && \
    sh autogen.sh && touch test-driver && automake --add-missing && \
    make -j4 && make -j4 install
RUN cd Gerris-ControllerModule && \
    cd gfsview-stable && \
    sh autogen.sh && automake --add-missing && \
    make -j4 && make -j4 install
RUN /sbin/ldconfig

WORKDIR /home/workspace/gerris
COPY Debian/change_python_location.sh .
COPY Debian/exec.sh .
RUN chmod +x change_python_location.sh exec.sh
RUN chown -R ${DEFAULT_USER}.${DEFAULT_USER} /home/workspace

USER ${DEFAULT_USER}
RUN cd /tmp && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /home/workspace/miniconda3
RUN /home/workspace/miniconda3/bin/conda install numpy pandas matplotlib
USER root
WORKDIR /home/gerris
RUN cd Gerris-ControllerModule && \
    cd gerris-stable && \
    sh autogen.sh && touch test-driver && automake --add-missing && \
    make -j4 && make -j4 install
USER ${DEFAULT_USER}
WORKDIR /home/workspace/gerris
VOLUME /media/DATA/workspace
ENTRYPOINT ["/home/workspace/gerris/exec.sh"]


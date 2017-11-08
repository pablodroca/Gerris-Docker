FROM ubuntu
RUN apt update
RUN apt-get -yq install libglib2.0-dev libnetpbm10-dev m4 libproj-dev libgsl0-dev libnetcdf-dev libode-dev libfftw3-dev libhypre-dev libgtkglext1-dev libstartup-notification0-dev ffmpeg
RUN apt-get -yq install darcs autoconf libtool-bin automake
ENV GERRIS_HOME /home/gerris
RUN mkdir -p ${GERRIS_HOME}
RUN cd ${GERRIS_HOME} && darcs get http://gerris.dalembert.upmc.fr/darcs/gerris-stable && \
    darcs get http://gerris.dalembert.upmc.fr/darcs/gts-stable && \
    darcs get http://gerris.dalembert.upmc.fr/darcs/gfsview-stable
RUN apt-get -yq install 
RUN cd ${GERRIS_HOME} && cd gts-stable && \
    sh autogen.sh && automake --add-missing && \
    ./configure && \
    make && make install
RUN cd ${GERRIS_HOME} && cd gerris-stable && \
    sh autogen.sh && touch test-driver && automake --add-missing && \
    make && make install
RUN cd ${GERRIS_HOME} && cd gfsview-stable && \
    sh autogen.sh && automake --add-missing && \
    make && make install
RUN /sbin/ldconfig
RUN apt-get -yq install git
RUN cd ${GERRIS_HOME} && git clone https://github.com/pablodroca/Gerris-ControllerModule.git
RUN cd ${GERRIS_HOME} && cd Gerris-ControllerModule && \
    cd gerris-stable && \
    sh autogen.sh && touch test-driver && automake --add-missing && \
    make && make install
RUN apt-get -yq install python-dev wget vim
RUN apt-get -yq install octave
RUN cd /tmp && wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py
RUN pip install oct2py numpy scipy




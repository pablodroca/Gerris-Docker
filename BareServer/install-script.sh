#Step by Step for gerris install.
#This script is a guide on how to install a Gerris system and shouldn't be used in production servers as is without testing performance and security improvements

DEFAULT_USER=pablo
DEFAULT_UID=1000
GERRIS_DIR=/src/gerris
WORK_DIR=/home/pablo/workspace

sudo groupadd -r -g ${DEFAULT_UID} ${DEFAULT_USER} && sudo useradd -r -g ${DEFAULT_USER} -u ${DEFAULT_UID} ${DEFAULT_USER} && sudo usermod -aG sudo ${DEFAULT_USER}
sudo apt update && \
    sudo ln -fs /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime && \
    sudo apt -yq install tzdata && \
    sudo apt -yq install libglib2.0-dev libnetpbm10-dev m4 libproj-dev libgsl0-dev libnetcdf-dev libode-dev libfftw3-dev libhypre-dev libgtkglext1-dev libstartup-notification0-dev ffmpeg \
        autoconf libtool-bin automake git python-dev wget vim \
        libosmesa6-dev libftgl-dev bc iptables


sudo mkdir -p ${GERRIS_DIR}
sudo chown ${DEFAULT_USER}.${DEFAULT_USER} ${GERRIS_DIR}
sudo su ${DEFAULT_USER}

cd ${GERRIS_DIR}
git clone https://github.com/pablodroca/Gerris-ControllerModule.git
cd ${GERRIS_DIR}/Gerris-ControllerModule && \
    cd gts-stable && \
    sh autogen.sh && automake --add-missing && \
    ./configure && \
    make -j4  && sudo make install
cd ${GERRIS_DIR}/Gerris-ControllerModule && \
    cd gerris-stable && \
    sh autogen.sh && touch test-driver && automake --add-missing && \
    ./configure && \
    make -j4 && sudo make install
cd ${GERRIS_DIR}/Gerris-ControllerModule && \
    cd gfsview-stable && \
    sh autogen.sh && automake --add-missing && \
    make -j4 && sudo make install
ldconfig

mkdir -p ${WORK_DIR}

cd /tmp && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p ${HOME}/miniconda3
${HOME}/miniconda3/bin/conda install numpy pandas matplotlib


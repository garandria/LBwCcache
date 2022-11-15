#!/bin/bash

source /etc/profile.d/modules.sh
set -x
module load singularity

if [ ! -d /srv/local/grandria ] ; then
    mkdir /srv/local/grandria
fi

cd /srv/local/grandria/
# https://hub.docker.com/r/kernelci/build-base
wget https://raw.githubusercontent.com/garandria/LBwCcache/master/prog.py
singularity build -F kernelci-build-base.sif docker://kernelci/build-base
singularity run --bind /srv/local/grandria:/srv/local/grandria kernelci-build-base.sif

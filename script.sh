#!/bin/bash

source /etc/profile.d/modules.sh
set -x
module load singularity

if [ ! -d /srv/local/grandria ] ; then
    mkdir /srv/local/grandria
fi

cd /srv/local/grandria/
singularity build -F build-env.sif docker://garandria/build-env
singularity run build-env.sif

#!/bin/bash

source /etc/profile.d/modules.sh
set -x
module load singularity

if [ ! -d /srv/local/grandria ] ; then
    mkdir /srv/local/grandria
fi

cd /srv/local/grandria/

if [ ! -d linux-5.13.tar.gz ] ; then
    curl -O https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.13.tar.gz ;
fi

if [ ! -d linux-5.13 ] ; then
    tar -xf linux-5.13.tar.gz ;
fi

git clone https://github.com/garandria/LBwCcache.git
singularity build -F build-env.sif docker://garandria/build-env
time singularity run --bind /srv/local/grandria:/srv/local/grandria build-env.sif python3 LBwCcache/main.py --linux-src /srv/local/grandria/linux-5.13 --configurations /srv/local/grandria/LBwCcache/b1 >> duration.time
rsync -av /srv/local/grandria/linux-5.13 grandria@tatooine.irisa.fr:/srv/data1/nfs/linux/igrida/

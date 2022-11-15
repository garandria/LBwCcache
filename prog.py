#!/usr/bin/env python3

import os

WORKDIR = "/srv/local/grandria"

def main():
    os.chdir(WORKDIR)
    os.system("apt-get update --allow-releaseinfo-change")
    os.system("apt-get install time")
    if not os.path.isfile("linux-5.13.tar.gz"):
        os.system("wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.13.tar.gz")
    if not os.path.isdir("linux-5.13"):
        os.system("tar -xf linux-5.13.tar.gz")
    os.system("git clone https://github.com/garandria/LBwCcache.git")
    os.chdir("LBwCcache")
    os.system("git checkout test")
    os.system("cp -r b1 ..")
    os.chdir("..")
    os.system("python3 LBwCcache/main.py"
              " --linux-src /srv/local/grandria/linux-5.13"
              " --configurations /srv/local/grandria/b1")

if __name__ == "__main__":
    main()

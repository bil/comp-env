set -o nounset
set -o errexit
set -o pipefail

REPO=http://us.archive.ubuntu.com/ubuntu
DIST=noble
TMPDIR=/tmp
export DEBIAN_FRONTEND=noninteractive

# update repositories
echo "deb $REPO $DIST main restricted universe multiverse" > /etc/apt/sources.list
echo "deb-src $REPO $DIST main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb $REPO $DIST-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src $REPO $DIST-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb $REPO $DIST-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src $REPO $DIST-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb http://security.ubuntu.com/ubuntu $DIST-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src http://security.ubuntu.com/ubuntu $DIST-security main restricted universe multiverse" >> /etc/apt/sources.list

# fully upgrade
apt-get -qq update
apt-get -qq install apt-utils
apt-get -qq upgrade
apt-get -qq dist-upgrade

# base packages
apt-get -qq install wget curl rsync git zip unzip p7zip man-db less vim nano ca-certificates

# python + pip
apt-get -qq install python3 python3-venv
rm /usr/lib/python3.12/EXTERNALLY-MANAGED
curl https://bootstrap.pypa.io/get-pip.py -o $TMPDIR/get-pip.py
python3 $TMPDIR/get-pip.py
rm $TMPDIR/get-pip.py

# node.js + npm + nvm
export NVM_DIR=/opt/nvm
NODE_VERSION=v24.15.0
#apt-get -qq install nodejs npm
mkdir -p $NVM_DIR
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
\. "$NVM_DIR/nvm.sh"
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION
nvm use default

# rclone
curl https://rclone.org/install.sh | bash

# clean up
apt-get -qq autoremove
apt-get -qq clean

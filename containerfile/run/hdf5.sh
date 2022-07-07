set -o nounset
set -o errexit
set -o pipefail

NUM_CPUS=12
TMPDIR=/tmp
export DEBIAN_FRONTEND=noninteractive

HDF5=1.10.8
HDF5_TRIM=`echo $HDF5|cut -c1-4`
HDF5_PATH=/usr/local
H5PY=3.7.0

# hdf5 dependency dev libraries
apt-get -qq install zlib1g-dev libssl-dev libcurl4-openssl-dev

# hdf5
wget -q https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-$HDF5_TRIM/hdf5-$HDF5/src/hdf5-$HDF5.tar.gz -O $TMPDIR/hdf5-$HDF5.tar.gz
tar -C $TMPDIR -xf $TMPDIR/hdf5-$HDF5.tar.gz
cd $TMPDIR/hdf5-$HDF5
./configure --enable-build-mode=production --enable-ros3-vfd --prefix=$HDF5_PATH
make -j $NUM_CPUS
make install
cd $TMPDIR
rm -rf $TMPDIR/hdf5-$HDF5
rm $TMPDIR/hdf5-$HDF5.tar.gz

# rebuild ld cache
ldconfig

# h5py
wget -q https://github.com/h5py/h5py/archive/$H5PY.tar.gz -O $TMPDIR/h5py-$H5PY.tar.gz
tar -C $TMPDIR -xf $TMPDIR/h5py-$H5PY.tar.gz
cd $TMPDIR/h5py-$H5PY
HDF5_DIR=$HDF5_PATH pip install .
cd $TMPDIR
rm -rf $TMPDIR/h5py-$H5PY
rm $TMPDIR/h5py-$H5PY.tar.gz

# cleanup
apt-get -qq autoremove
apt-get -qq clean
pip cache purge

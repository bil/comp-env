set -o nounset
set -o errexit
set -o pipefail

NUM_CPUS=12
TMPDIR=/tmp
export DEBIAN_FRONTEND=noninteractive

# GNU toolchain + fortran
apt-get -qq install build-essential gfortran cmake
# python3-dev
apt-get -qq install python3-dev
# need meson for scipy as of 1.9.0

# Intel MKL
echo "debconf libmkl-rt/use-as-default-blas-lapack select true" | debconf-set-selections
echo "debconf libmkl-rt/exact-so-3-selections select libblas.so.3, liblapack.so.3, libblas64.so.3, liblapack64.so.3" | debconf-set-selections
apt-get -qq install intel-mkl
echo "MKL_THREADING_LAYER=GNU"		>> /etc/environment

# numpy & scipy
pip install cython pybind11
NPY_NUM_BUILD_JOBS=$NUM_CPUS pip install --no-binary numpy
NPY_NUM_BUILD_JOBS=$NUM_CPUS pip install scipy --no-binary scipy

# core python libraries
pip install matplotlib pandas sympy ipython pyyaml

# scikit-learn
pip install scikit-learn --no-binary scikit-learn

# cleanup
apt-get -qq autoremove
apt-get -qq clean
pip cache purge

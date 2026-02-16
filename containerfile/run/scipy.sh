set -o nounset
set -o errexit
set -o pipefail

NUM_CPUS=12
TMPDIR=/tmp
export DEBIAN_FRONTEND=noninteractive

# GNU toolchain + fortran
apt-get -qq install build-essential gfortran cmake pkg-config
# python3-dev
apt-get -qq install python3-dev

# Intel MKL
# echo "debconf libmkl-rt/use-as-default-blas-lapack select true" | debconf-set-selections
# echo "debconf libmkl-rt/exact-so-3-selections select libblas.so.3, liblapack.so.3, libblas64.so.3, liblapack64.so.3" | debconf-set-selections
# apt-get -qq install intel-mkl
# echo "MKL_THREADING_LAYER=GNU"		>> /etc/environment
#pip install mkl

# openblas
apt-get -qq install libopenblas-openmp-dev

# numpy & scipy
NPY_NUM_BUILD_JOBS=$NUM_CPUS pip install numpy --no-binary numpy -Csetup-args=-Dblas=openblas -Csetup-args=-Dlapack=openblas
pip install cython pythran meson ninja pybind11
NPY_NUM_BUILD_JOBS=$NUM_CPUS pip install scipy --no-binary scipy -Csetup-args=-Dblas=openblas -Csetup-args=-Dlapack=openblas

# core python libraries
pip install matplotlib pandas sympy pyyaml

# scikit-learn
pip install scikit-learn --no-binary scikit-learn

# cleanup
apt-get -qq autoremove
apt-get -qq clean
pip cache purge

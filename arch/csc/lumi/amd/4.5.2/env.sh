# (C) Copyright 1988- ECMWF.
#
# This software is licensed under the terms of the Apache Licence Version 2.0
# which can be obtained at http://www.apache.org/licenses/LICENSE-2.0.
# In applying this licence, ECMWF does not waive the privileges and immunities
# granted to it by virtue of its status as an intergovernmental organisation
# nor does it submit to any jurisdiction.

# Source me to get the correct configure/build/run environment

# Store tracing and disable (module is *way* too verbose)
{ tracing_=${-//[^x]/}; set +x; } 2>/dev/null

module_load() {
  echo "+ module load $1"
  module load $1
}
module_unload() {
  echo "+ module unload $1"
  module unload $1
}

# Unload to be certain
module reset

# Load modules
module_load LUMI/21.12
module_load partition/EAP
module_load rocm/4.5.2
module_load buildtools/21.12
module_load cray-python/3.9.4.2

# Load hand-installed dependencies
source ~/dwarf-p-cloudsc/deps/amd/13.0.0/deps_env.sh
export HDF5_DIR=$HOME/dwarf-p-cloudsc/deps/amd/13.0.0

# Specify compilers
export CC=amdclang CXX=amdclang++ FC=amdflang

set -x

export CRAY_ADD_RPATH=yes

# Restore tracing to stored setting
{ if [[ -n "$tracing_" ]]; then set -x; else set +x; fi } 2>/dev/null

export ECBUILD_TOOLCHAIN="./toolchain.cmake"

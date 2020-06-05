#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PATH="/usr/local/opt/gettext/bin:$PATH"
build_dir=${DIR}/libs_build
download_dir=${DIR}/libs_src
PATH=${build_dir}/bin:${PATH}
LD_LIBRARY_PATH=${build_dir}/lib:${LD_LIBRARY_PATH}
# export CPLUS_INCLUDE_PATH=:${build_dir}/include:${CPLUS_INCLUDE_PATH}

if [ -z "${ZFP_CMAKE}" ]; then
  ZFP_CMAKE=cmake
fi

if [ -z "${MYCC}" ]; then
  MYCC=${CC}
fi

if [ -z "${MYCXX}" ]; then
  MYCC=${CXX}
fi

alias make="make -j 4"

mkdir -p "${build_dir}"

# echo "Build openssl"
# cd "${download_dir}/openssl"
# SYSTEM=$(uname -s) ./config --prefix="${build_dir}"
# make
# make test
# make install


echo "Build lerc"
cd "${download_dir}/lerc"
cp ${DIR}/patch_dir/lerc/CMakeLists.txt .
mkdir -p build2
cd build2
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install

echo "Build giflib"
cd "${download_dir}/giflib"
patch Makefile ../../giflib.patch -N || True
make
make install PREFIX="${build_dir}"


echo "Build snappy"
cd "${download_dir}/snappy"
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DBUILD_SHARED_LIBS=1 ..
make
make install

echo "Build jxrlib"
cd "${download_dir}/jxrlib"
cp ../../patch_dir/jxrlib/Makefile .
make
mkdir -p "${build_dir}/lib"
if [ -f libjpegxr.so ]; then
  cp libjpegxr.so "${build_dir}/lib/"
  cp libjxrglue.so "${build_dir}/lib/"
else
  cp libjpegxr.dylib "${build_dir}/lib/"
  cp libjxrglue.dylib "${build_dir}/lib/"
fi
cp image/sys/windowsmediaphoto.h "${build_dir}/include"
cp common/include/*.h "${build_dir}/include"
cp jxrgluelib/JXR*.h "${build_dir}/include"

echo "Build zopfli"
cd "${download_dir}/zopfli"
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DZOPFLI_BUILD_SHARED=1 -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install
mkdir -p "${build_dir}/include/zopfli"
cp "../src/zopfli/zopfli.h" "${build_dir}/include/zopfli"
cp "../src/zopfli/zlib_container.h" "${build_dir}/include/zopfli"
cp "../src/zopfli/gzip_container.h" "${build_dir}/include/zopfli"

echo "Build brotli"
cd "${download_dir}/brotli"
mkdir -p build2
cd build2
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install

echo "Build brunsli"
cd "${download_dir}/brunsli"
mkdir -p build2
cd build2
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install

echo "Build libaec"
cd "${download_dir}/libaec"
mkdir -p build
cd build
CFLAGS=-DENABLE_RSI_PADDING=1 cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make
make install

echo "Build charls"
cd "${download_dir}/charls" || exit 1
mkdir -p build
cd build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DBUILD_SHARED_LIBS=1 -DCMAKE_BUILD_TYPE=Release ..
make install

#echo "build swig"
#cd "${download_dir}/swig-3.0.10" || exit 1
#./configure --prefix="${build_dir}"
#make
#make install

echo "Build libpng"
cd "${download_dir}/libpng" || exit 1
mkdir -p build
mkdir -p "${build_dir}/lib/libpng"
cd build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make install


echo "Build bzip2"
cd "${download_dir}/bzip2" || exit 1
git stash
git apply "${DIR}/bzip2.patch" # for macos build
make -f Makefile-libbz2_so
make install PREFIX="${build_dir}"
cp libbz2.so.1.0.8 "${build_dir}"/lib
cp libbz2.so.1.0 "${build_dir}"/lib

echo "Build c-blosc"
cd "${download_dir}/c-blosc" || exit 1
mkdir -p build
cd build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
cmake --build .
# ctest
cmake --build . --target install

echo "Build libjpeg-turbo"
cd "${download_dir}/libjpeg-turbo" || exit 1
mkdir -p build
cd build || exit 1
cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${build_dir}" -DWITH_JPEG8=1 -WITH_12BIT=1 ..
make install

echo "Build liblzf"
cd "${download_dir}/liblzf" || exit 1
sh ./configure --prefix="${build_dir}"
make
make install

echo "Build libwebp"
cd "${download_dir}/libwebp" || exit 1
sh ./autogen.sh
sh ./configure --prefix="${build_dir}"
make
make install
cd "${build_dir}/lib" || exit 1
ln -s libwebp.so.7 libwebp.so.6

echo "Build Little-CMS"
cd "${download_dir}/Little-CMS" || exit 1
sh ./configure --prefix="${build_dir}"
make
make install

echo "Build lz4"
cd "${download_dir}/lz4" || exit 1
make
PREFIX="${build_dir}" make install

echo "Build openjpeg"
cd "${download_dir}/openjpeg" || exit 1
mkdir -p build
cd build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make install

echo "Build xz"
cd "${download_dir}/xz" || exit 1
sh ./autogen.sh
sh ./configure --prefix="${build_dir}"
make
make check
make install
make installcheck

echo "Build zfp"
cd "${download_dir}/zfp" || exit 1
mkdir -p build
cd build || exit 1
CC=${MYCC} CXX=${MYCXX} ${ZFP_CMAKE} -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
CC=${MYCC} CXX=${MYCXX}  make install

echo "Build zlib"
cd "${download_dir}/zlib" || exit 1
mkdir -p build
cd build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make install

echo "Build zstd"
cd "${download_dir}/zstd" || exit 1
make
PREFIX="${build_dir}" make install

echo "Build libtiff"
cd "${download_dir}/libtiff"
mkdir -p build2
cd build2
CMAKE_PREFIX_PATH=${build_dir} cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make
make install
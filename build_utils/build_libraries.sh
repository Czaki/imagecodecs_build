#!/usr/bin/env bash
set -e
set -x
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

export MAKEFLAGS="-j 4"

mkdir -p "${build_dir}"

# echo "Build openssl"
# cd "${download_dir}/openssl"
# SYSTEM=$(uname -s) ./config --prefix="${build_dir}"
# make
# make test
# make install

# echo "Build hdf5"
# cd "${download_dir}/hdf5"
# mkdir -p _build
# cd _build || exit 1
# cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DHDF5_BUILD_TOOLS=OFF -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
# make
# make install

echo "Build zlib"
cd "${download_dir}/zlib" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make install

echo "Build cfitsio"
cd "${download_dir}/cfitsio" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DUseCurl=OFF -DUSE_PTHREADS=OFF -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make install

echo "Build Little-CMS"
cd "${download_dir}/Little-CMS" || exit 1
sh ./configure --prefix="${build_dir}"
make
make install

echo "Build zlib-ng"
cd "${download_dir}/zlib-ng" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DZLIB_COMPAT=OFF -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make install

echo "Build lz4"
cd "${download_dir}/lz4" || exit 1
make
PREFIX="${build_dir}" make install

echo "Build zstd"
cd "${download_dir}/zstd" || exit 1
make -j 1
PREFIX="${build_dir}" make install

echo "Build lzo"
cd "${download_dir}/lzo" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install

echo "Build liblzf"
cd "${download_dir}/liblzf" || exit 1
sh ./configure --prefix="${build_dir}"
make
make install

echo "Build bzip2"
cd "${download_dir}/bzip2" || exit 1
make -f Makefile-libbz2_so
make install PREFIX="${build_dir}"
cp libbz2.so.1.0.8 "${build_dir}"/lib
cp libbz2.so.1.0 "${build_dir}"/lib

echo "Build libdeflate"
cd "${download_dir}/libdeflate" || exit 1
make
make install PREFIX="${build_dir}"

echo "Build lerc"
cd "${download_dir}/lerc" || exit 1
cp ${DIR}/patch_dir/lerc/CMakeLists.txt .
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install

echo "Build xz"
cd "${download_dir}/xz" || exit 1
sh ./autogen.sh
sh ./configure --prefix="${build_dir}"
make
make check
make install
make installcheck

echo "Build snappy"
cd "${download_dir}/snappy" || exit 1
mkdir -p _build
cd _build || exit 1
CFLAGS="-I${build_dir}/include" CXXFLAGS="-I${build_dir}/include" cmake  -DCMAKE_INSTALL_PREFIX="${build_dir}" -DSNAPPY_BUILD_BENCHMARKS=OFF -DSNAPPY_BUILD_TESTS=OFF -DBUILD_SHARED_LIBS=ON  ..
make
make install

echo "Build zopfli"
cd "${download_dir}/zopfli" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DZOPFLI_BUILD_SHARED=ON -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install
mkdir -p "${build_dir}/include/zopfli"
cp "../src/zopfli/zopfli.h" "${build_dir}/include/zopfli"
cp "../src/zopfli/zlib_container.h" "${build_dir}/include/zopfli"
cp "../src/zopfli/gzip_container.h" "${build_dir}/include/zopfli"

echo "Build brotli"
cd "${download_dir}/brotli" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install

echo "Build brunsli"
cd "${download_dir}/brunsli" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
make
make install

echo "Build libaec"
cd "${download_dir}/libaec" || exit 1
mkdir -p _build
cd _build || exit 1
CFLAGS=-DENABLE_RSI_PADDING=1 cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make
make install

echo "Build c-blosc"
cd "${download_dir}/c-blosc" || exit 1
mkdir -p _build
cd _build || exit 1
CMAKE_PREFIX_PATH=${build_dir} cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" -DDEACTIVATE_SNAPPY=OFF -DPREFER_EXTERNAL_SNAPPY=ON -DPREFER_EXTERNAL_LZ4=ON -DPREFER_EXTERNAL_ZLIB=ON -DPREFER_EXTERNAL_ZSTD=ON -DDEACTIVATE_AVX2=ON ..
cmake --build .
# ctest
cmake --build . --target install

echo "Build giflib"
cd "${download_dir}/giflib" || exit 1
patch Makefile ../../giflib.patch -N || true
make
make install PREFIX="${build_dir}"

#echo "build swig"
#cd "${download_dir}/swig-3.0.10" || exit 1
#./configure --prefix="${build_dir}"
#make
#make install

echo "Build libpng"
cd "${download_dir}/libpng" || exit 1
mkdir -p "${build_dir}/lib/libpng"
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make install

echo "Build libwebp"
cd "${download_dir}/libwebp" || exit 1
sh ./autogen.sh
sh ./configure --prefix="${build_dir}"
make
make install
cd "${build_dir}/lib" || exit 1
ln -s libwebp.so.7 libwebp.so.6 || true


echo "Build libjpeg-turbo"
cd "${download_dir}/libjpeg-turbo" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${build_dir}" -DENABLE_STATIC=OFF -DWITH_JPEG8=ON ..
make install

echo "Build libjpeg-turbo 12-bit"
cd "${download_dir}/libjpeg-turbo12" || exit 1
mkdir -p "${build_dir}/libjpeg12"
mkdir -p _build
cd _build || exit 1
cmake -G"Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${build_dir}/libjpeg12" -DENABLE_STATIC=OFF -DWITH_JPEG8=ON -DWITH_12BIT=ON ..
make install
if [ -d "${build_dir}"/libjpeg12/lib64 ]; then
  cp "${build_dir}"/libjpeg12/lib64/lib* "${build_dir}/lib64"
fi
if [ -d "${build_dir}"/libjpeg12/lib ]; then
  cp "${build_dir}"/libjpeg12/lib/lib* "${build_dir}/lib"
fi

echo "Build openjpeg"
cd "${download_dir}/openjpeg" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make install

echo "Build jxrlib"
cd "${download_dir}/jxrlib" || exit 1
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

echo "Build charls"
cd "${download_dir}/charls" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DBUILD_SHARED_LIBS=ON -DCMAKE_BUILD_TYPE=Release ..
make install

# only build jpeg-xl for 64-bit linux
if [[ "$OSTYPE" != "darwin"* ]]; then
if [ "$AUDITWHEEL_ARCH" != "i686" ]; then
echo "Build jpeg-xl"
cd "${download_dir}/jpeg-xl" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DBUILD_TESTING=OFF -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make
make install
fi
fi

echo "Build dav1d"
cd "${download_dir}/dav1d" || exit 1
mkdir -p _build
cd _build || exit 1
meson .. --default-library=static
ninja
DESTDIR="${build_dir}" meson install

echo "Build aom"
cd "${download_dir}/aom" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" -DENABLE_DOCS=OFF -DENABLE_EXAMPLES=OFF -DENABLE_TESTDATA=OFF -DENABLE_TESTS=OFF -DENABLE_TOOLS=OFF -DBUILD_SHARED_LIBS=ON ..
make -j 1
make install

echo "Build libavif"
cd "${download_dir}/libavif" || exit 1
mkdir -p _build
cd _build || exit 1
cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" -DAVIF_BUILD_APPS=OFF -DAVIF_BUILD_TESTS=OFF -DAVIF_CODEC_AOM=ON -DAVIF_CODEC_DAV1D=ON -DCMAKE_PREFIX_PATH="${build_dir};${build_dir}/usr/local" ..
make
make install

echo "Build zfp"
cd "${download_dir}/zfp" || exit 1
mkdir -p _build
cd _build || exit 1
if [[ "$OSTYPE" == "darwin"* ]]; then
#    CFLAGS="-D_OPENMP=4 -I${build_dir}/include"  cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" -DZFP_WITH_OPENMP=ON ..
    CFLAGS="-I${build_dir}/include"  cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" -DCMAKE_MACOSX_RPATH="${build_dir}/lib" ..
else
    if [[ "$SKIP_OMP" == "0" ]]; then
      ${ZFP_CMAKE} -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
    else
      ${ZFP_CMAKE} -DCMAKE_INSTALL_PREFIX="${build_dir}" -DZFP_WITH_OPENMP=ON ..
    fi
fi
make install

echo "Build libtiff"
cd "${download_dir}/libtiff" || exit 1
mkdir -p _build
cd _build || exit 1
CMAKE_PREFIX_PATH=${build_dir} cmake -DCMAKE_INSTALL_PREFIX="${build_dir}" ..
make
make install

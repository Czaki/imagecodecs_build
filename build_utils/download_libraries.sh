#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
download_dir=${DIR}/libs_src
mkdir -p "${download_dir}"
git clone --depth 1 --branch v1.2.11 https://github.com/madler/zlib "${download_dir}/zlib"
git clone --depth 1 --branch v1.9.3 https://github.com/lz4/lz4 "${download_dir}/lz4"
git clone --depth 1 --branch v1.5.0 https://github.com/facebook/zstd "${download_dir}/zstd"
git clone --depth 1 --branch v1.21.0 https://github.com/Blosc/c-blosc "${download_dir}/c-blosc"
git clone --depth 1 --branch bzip2-1.0.8 git://sourceware.org/git/bzip2.git "${download_dir}/bzip2"
git clone --depth 1 --branch v5.2.4 https://github.com/xz-mirror/xz "${download_dir}/xz"
git clone --depth 1 --branch v1.6.37 https://github.com/glennrp/libpng "${download_dir}/libpng"
git clone --depth 1 --branch v1.2.0 https://github.com/webmproject/libwebp "${download_dir}/libwebp"
git clone --depth 1 --branch v4.3.0 https://gitlab.com/libtiff/libtiff "${download_dir}/libtiff"
git clone --depth 1 --branch 2.1.0 https://github.com/libjpeg-turbo/libjpeg-turbo "${download_dir}/libjpeg-turbo"
git clone --depth 1 --branch 2.1.0 https://github.com/libjpeg-turbo/libjpeg-turbo "${download_dir}/libjpeg-turbo12"
git clone --depth 1 --branch 2.2.0 https://github.com/team-charls/charls "${download_dir}/charls"
git clone --depth 1 --branch v2.4.0 https://github.com/uclouvain/openjpeg "${download_dir}/openjpeg"
git clone --depth 1 --branch 0.5.5 https://github.com/LLNL/zfp "${download_dir}/zfp"
git clone --depth 1 --branch v1.0.4 https://gitlab.dkrz.de/k202009/libaec "${download_dir}/libaec"
git clone --depth 1 --branch 1.1.8 https://github.com/google/snappy "${download_dir}/snappy"
git clone --depth 1 --branch zopfli-1.0.3 https://github.com/google/zopfli "${download_dir}/zopfli"
git clone --depth 1 --branch v1.0.9 https://github.com/google/brotli "${download_dir}/brotli"
git clone --depth 1 --branch v0.1 https://github.com/google/brunsli "${download_dir}/brunsli"
git clone --depth 1 --branch v2.2.1 https://github.com/Esri/lerc "${download_dir}/lerc"
git clone --depth 1 --branch v1.7 https://github.com/ebiggers/libdeflate "${download_dir}/libdeflate"
git clone --depth 1 --branch v0.9.1 https://github.com/AOMediaCodec/libavif "${download_dir}/libavif"
git clone --depth 1 --branch 0.9.0 https://github.com/videolan/dav1d "${download_dir}/dav1d"
git clone --depth 1 --branch v3.1.0 https://aomedia.googlesource.com/aom "${download_dir}/aom"
git clone --depth 1 --branch 2.12 https://github.com/mm2/Little-CMS "${download_dir}/Little-CMS"
git clone --depth 1 --branch v0.3.7 https://gitlab.com/wg1/jpeg-xl "${download_dir}/jpeg-xl"
git clone --depth 1 --branch 2.0.3 https://github.com/zlib-ng/zlib-ng "${download_dir}/zlib-ng"

cd "${download_dir}/jpeg-xl" || exit 1
git submodule update --init --recursive

cd "${download_dir}/brunsli" || exit 1
git submodule update --init

cd "$DIR" || exit 1

wget http://heasarc.gsfc.nasa.gov/FTP/software/fitsio/c/cfitsio-3.49.tar.gz
tar zxvf  cfitsio-3.49.tar.gz -C "${download_dir}"
mv "${download_dir}/cfitsio-3.49" "${download_dir}/cfitsio"

wget http://deb.debian.org/debian/pool/main/j/jxrlib/jxrlib_1.1.orig.tar.gz
tar zxvf  jxrlib_1.1.orig.tar.gz -C "${download_dir}"
mv "${download_dir}/jxrlib-1.1" "${download_dir}/jxrlib"

wget -q http://dist.schmorp.de/liblzf/liblzf-3.6.tar.gz
tar zxvf  liblzf-3.6.tar.gz -C "${download_dir}"
mv "${download_dir}/liblzf-3.6" "${download_dir}/liblzf"

# wget -q 'https://sourceforge.net/projects/swig/files/swig/swig-3.0.10/swig-3.0.10.tar.gz'
# tar zxvf  swig-3.0.10.tar.gz -C "${download_dir}"

wget https://sourceforge.net/projects/giflib/files/giflib-5.2.1.tar.gz/download -O giflib-5.2.1.tar.gz
tar zxvf  giflib-5.2.1.tar.gz -C "${download_dir}"
mv "${download_dir}/giflib-5.2.1" "${download_dir}/giflib"

wget http://www.oberhumer.com/opensource/lzo/download/lzo-2.10.tar.gz
tar zxvf  lzo-2.10.tar.gz -C "${download_dir}"
mv "${download_dir}/lzo-2.10" "${download_dir}/lzo"

rm jxrlib_1.1.orig.tar.gz liblzf-3.6.tar.gz giflib-5.2.1.tar.gz lzo-2.10.tar.gz

cd "${download_dir}/bzip2" || exit 1
git apply -v "${DIR}/bzip2.patch" || exit 1
cat -n Makefile-libbz2_so

cd "${download_dir}/libjpeg-turbo" || exit 1
git apply -v "${DIR}/libjpeg-turbo.patch" || exit 1

cd "${download_dir}/libjpeg-turbo12" || exit 1
git apply -v "${DIR}/libjpeg-turbo12.patch" || exit 1

cd "${download_dir}/cfitsio" || exit 1
git apply -v "${DIR}/cfitsio.patch" || exit 1

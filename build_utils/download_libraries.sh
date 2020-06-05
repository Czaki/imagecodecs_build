#!/usr/bin/env bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
download_dir=${DIR}/libs_src
mkdir -p "${download_dir}"
git clone --depth 1 --branch v1.2.11 https://github.com/madler/zlib "${download_dir}/zlib"
git clone --depth 1 --branch v1.9.2 https://github.com/lz4/lz4 "${download_dir}/lz4"
git clone --depth 1 --branch v1.4.5 https://github.com/facebook/zstd "${download_dir}/zstd"
git clone --depth 1 --branch v1.18.1 https://github.com/Blosc/c-blosc "${download_dir}/c-blosc"
git clone --depth 1 --branch bzip2-1.0.8 git://sourceware.org/git/bzip2.git "${download_dir}/bzip2"
git clone --depth 1 --branch v5.2.4 https://github.com/xz-mirror/xz "${download_dir}/xz"
git clone --depth 1 --branch v1.6.37 https://github.com/glennrp/libpng "${download_dir}/libpng"
git clone --depth 1 --branch v1.0.3 https://github.com/webmproject/libwebp "${download_dir}/libwebp"
git clone --depth 1 --branch v4.1.0 https://gitlab.com/libtiff/libtiff "${download_dir}/libtiff"
git clone --depth 1 --branch 2.0.4 https://github.com/libjpeg-turbo/libjpeg-turbo "${download_dir}/libjpeg-turbo"
git clone --depth 1 --branch 2.1.0 https://github.com/team-charls/charls "${download_dir}/charls"
git clone --depth 1 --branch v2.3.1 https://github.com/uclouvain/openjpeg "${download_dir}/openjpeg"
# git clone --depth 1 --branch v0.2.1 https://github.com/glencoesoftware/jxrlib "${download_dir}/jxrlib"
git clone --depth 1 --branch 0.5.5 https://github.com/LLNL/zfp "${download_dir}/zfp"
git clone --depth 1 --branch v1.0.4 https://gitlab.dkrz.de/k202009/libaec "${download_dir}/libaec"
git clone --depth 1 --branch 1.1.8 https://github.com/google/snappy "${download_dir}/snappy"
git clone --depth 1 --branch zopfli-1.0.3 https://github.com/google/zopfli "${download_dir}/zopfli"
git clone --depth 1 --branch v1.0.7 https://github.com/google/brotli "${download_dir}/brotli"
git clone --depth 1 --branch v0.1 https://github.com/google/brunsli "${download_dir}/brunsli"
git clone --depth 1 --branch lcms2.9 https://github.com/mm2/Little-CMS "${download_dir}/Little-CMS"
git clone --depth 1 --branch v2.1 https://github.com/Esri/lerc "${download_dir}/lerc"




cd "${download_dir}/brunsli"
git submodule update --init

cd "$DIR"

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

rm jxrlib_1.1.orig.tar.gz liblzf-3.6.tar.gz giflib-5.2.1.tar.gz

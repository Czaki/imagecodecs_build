#!/usr/bin/env bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
lib_dir=${DIR}/libs_build/lib

cd "${lib_dir}"

for filename in *.dylib ; do
  echo "$filename"
  if [ ! -h "${filename}" ] ; then
    echo "${lib_dir}/${filename}"
    install_name_tool -id "${lib_dir}/${filename}" "${filename}"
  fi
done
# install_name_tool -id "@loader_path/../lib/libtest.dylib" libtest.dylib

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libblosc.1.21.3.dylib"
install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libblosc2.2.6.1.dylib"
install_name_tool -change libsnappy.1.1.8.dylib @rpath/libsnappy.1.1.8.dylib  "${lib_dir}/libblosc.1.21.3.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libbrotlidec.1.0.9.dylib"
install_name_tool -change libbrotlicommon.1.dylib @rpath/libbrotlicommon.1.dylib  "${lib_dir}/libbrotlidec.1.0.9.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libbrotlienc.1.0.9.dylib"
install_name_tool -change libbrotlicommon.1.dylib @rpath/libbrotlicommon.1.dylib  "${lib_dir}/libbrotlienc.1.0.9.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libtiff.6.0.0.dylib"
install_name_tool -change libz.1.dylib @rpath/libz.1.dylib  "${lib_dir}/libtiff.6.0.0.dylib"
install_name_tool -change libdeflate.0.dylib @rpath/libdeflate.0.dylib  "${lib_dir}/libtiff.6.0.0.dylib"
install_name_tool -change libLerc.4.dylib @rpath/libLerc.4.dylib  "${lib_dir}/libtiff.6.0.0.dylib"
install_name_tool -change libzstd.1.5.2.dylib @rpath/libzstd.1.5.2.dylib  "${lib_dir}/libtiff.6.0.0.dylib"
install_name_tool -change libwebp.7.dylib @rpath/libwebp.7.dylib  "${lib_dir}/libtiff.6.0.0.dylib"

install_name_tool -add_rpath "${lib_dir}" "${lib_dir}/libavif.15.0.1.dylib"
install_name_tool -change libaom.3.dylib @rpath/libaom.3.dylib  "${lib_dir}/libavif.15.0.1.dylib"

install_name_tool -change libz.1.dylib @rpath/libz.1.dylib  "${lib_dir}/libblosc.1.21.3.dylib"
install_name_tool -change libz.1.dylib @rpath/libz.1.dylib  "${lib_dir}/libblosc2.2.6.1.dylib"

install_name_tool -change /usr/local/lib/libdeflate.0.dylib @rpath/libdeflate.0.dylib  "${lib_dir}/libtiff.6.0.0.dylib"

install_name_tool -change /usr/local/lib/libzstd.1.dylib @rpath/libzstd.1.5.2.dylib  "${lib_dir}/libtiff.6.0.0.dylib"
install_name_tool -change /usr/local/lib/libzstd.1.dylib @rpath/libzstd.1.5.2.dylib  "${lib_dir}/libblosc.1.21.3.dylib"
install_name_tool -change /usr/local/lib/libzstd.1.dylib @rpath/libzstd.1.5.2.dylib  "${lib_dir}/libblosc2.2.6.1.dylib"

install_name_tool -change /usr/local/lib/liblz4.1.dylib @rpath/liblz4.1.9.4.dylib  "${lib_dir}/libblosc.1.21.3.dylib"
install_name_tool -change /usr/local/lib/liblz4.1.dylib @rpath/liblz4.1.9.4.dylib  "${lib_dir}/libblosc2.2.6.1.dylib"

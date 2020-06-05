FROM quay.io/pypa/manylinux2010_x86_64
WORKDIR /opt/imagecodecs/build_utils

COPY install_cmake.sh .
RUN ./install_cmake.sh

COPY *patch /opt/imagecodecs/build_utils/

COPY gettext_install.sh .
COPY docker_prepare.sh .
RUN ./docker_prepare.sh

COPY download_libraries.sh .
RUN ./download_libraries.sh

COPY patch_dir/ patch_dir/

COPY build_libraries.sh .
RUN ./build_libraries.sh

ENV BASE_PATH /opt/imagecodecs/
ENV BASE_LIB_PATH ${BASE_PATH}/build_utils/libs_build/
ENV LD_LIBRARY_PATH ${BASE_LIB_PATH}/lib:${BASE_LIB_PATH}/lib64:/usr/local/lib:/usr/local/lib64

ENV C_INCLUDE_PATH ${BASE_LIB_PATH}/include
ENV LIBRARY_PATH ${LD_LIBRARY_PATH}
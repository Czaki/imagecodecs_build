FROM quay.io/pypa/manylinux2010_x86_64
WORKDIR /opt/imagecodecs/build_utils

COPY install_cmake.sh .
RUN ./install_cmake.sh

COPY install_nasm.sh .
RUN ./install_nasm.sh

COPY install_ninja.sh .
RUN ./install_ninja.sh

COPY *patch /opt/imagecodecs/build_utils/

ENV PATH /opt/python/cp38-cp38/bin:${PATH}

COPY gettext_install.sh .
COPY docker_prepare.sh .
RUN ./docker_prepare.sh

COPY download_libraries.sh .
RUN ./download_libraries.sh

COPY patch_dir/ patch_dir/

COPY build_libraries.sh .
RUN ./build_libraries.sh

FROM quay.io/pypa/manylinux2010_x86_64
WORKDIR /opt/imagecodecs/build_utils

RUN mkdir /opt/imagecodecs/build_utils/libs_build

COPY --from=0 /opt/imagecodecs/build_utils/libs_build/lib libs_build/lib
COPY --from=0 /opt/imagecodecs/build_utils/libs_build/lib64 libs_build/lib64
COPY --from=0 /opt/imagecodecs/build_utils/libs_build/include libs_build/include
COPY --from=0 /opt/imagecodecs/build_utils/libs_build/usr libs_build/usr

ENV BASE_PATH /opt/imagecodecs/
ENV BASE_LIB_PATH ${BASE_PATH}/build_utils/libs_build/
ENV LD_LIBRARY_PATH ${BASE_LIB_PATH}/lib:${BASE_LIB_PATH}/lib64:/usr/local/lib:/usr/local/lib64

ENV C_INCLUDE_PATH ${BASE_LIB_PATH}/include
ENV LIBRARY_PATH ${LD_LIBRARY_PATH}

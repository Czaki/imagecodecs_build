cmake_minimum_required (VERSION 3.11)
project (Lerc)

set(CMAKE_CXX_STANDARD 17)

file(GLOB SOURCES 
    "src/LercLib/*"
    "src/LercLib/Lerc1Decode/*"
    "include"
)
message(${SOURCES})

add_library(lerc SHARED ${SOURCES})
set_target_properties(lerc PROPERTIES PUBLIC_HEADER "src/LercLib/Lerc_c_api.h")

target_link_libraries (lerc)

include(GNUInstallDirs)

message(${CMAKE_INSTALL_LIBDIR})

install(
    TARGETS lerc
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

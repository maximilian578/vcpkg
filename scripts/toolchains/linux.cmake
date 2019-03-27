if(NOT _VCPKG_LINUX_TOOLCHAIN)
set(_VCPKG_LINUX_TOOLCHAIN 1)
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
    set(CMAKE_CROSSCOMPILING OFF CACHE BOOL "")

    if (NOT CMAKE_SYSTEM_PROCESSOR)
        # TODO: This should be replaced with a switch on VCPKG_TARGET_ARCHITECTURE once we know what linux systems "natively" define for each of the targets
        set(CMAKE_SYSTEM_PROCESSOR "${CMAKE_HOST_SYSTEM_PROCESSOR}" CACHE STRING "")
        message("CMAKE_HOST_SYSTEM_PROCESSOR is ${CMAKE_HOST_SYSTEM_PROCESSOR}")
    endif()
else()
    if (NOT CMAKE_SYSTEM_PROCESSOR)
        set(CMAKE_SYSTEM_PROCESSOR "x86_64" CACHE STRING "")
        message("CMAKE_HOST_SYSTEM_PROCESSOR defaulted to x86_64")
    endif()
endif()
set(CMAKE_SYSTEM_NAME Linux CACHE STRING "")

get_property( _CMAKE_IN_TRY_COMPILE GLOBAL PROPERTY IN_TRY_COMPILE )
if(NOT _CMAKE_IN_TRY_COMPILE)
    string(APPEND CMAKE_C_FLAGS_INIT " -fPIC ${VCPKG_C_FLAGS} ")
    string(APPEND CMAKE_CXX_FLAGS_INIT " -fPIC ${VCPKG_CXX_FLAGS} ")
    string(APPEND CMAKE_C_FLAGS_DEBUG_INIT " ${VCPKG_C_FLAGS_DEBUG} ")
    string(APPEND CMAKE_CXX_FLAGS_DEBUG_INIT " ${VCPKG_CXX_FLAGS_DEBUG} ")
    string(APPEND CMAKE_C_FLAGS_RELEASE_INIT " ${VCPKG_C_FLAGS_RELEASE} ")
    string(APPEND CMAKE_CXX_FLAGS_RELEASE_INIT " ${VCPKG_CXX_FLAGS_RELEASE} ")

    string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT " ${VCPKG_LINKER_FLAGS} ")
    if(VCPKG_CRT_LINKAGE STREQUAL "static")
        string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT "-static ")
        string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT "-static ")
    endif()
endif()
endif()

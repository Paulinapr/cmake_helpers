# This file is part of Desktop App Toolkit,
# a set of libraries for developing nice desktop applications.
#
# For license and copyright information please follow this link:
# https://github.com/desktop-app/legal/blob/master/LEGAL

include(CheckCXXCompilerFlag)

function(target_link_options_if_exists target_name)
    set(list ${ARGV})
    list(REMOVE_AT list 0)

    set(writing_now "")
    set(private_options "")
    set(public_options "")
    set(interface_options "")
    foreach (entry ${list})
        if (${entry} STREQUAL "PRIVATE" OR ${entry} STREQUAL "PUBLIC" OR ${entry} STREQUAL "INTERFACE")
            set(writing_now ${entry})
        else()
            check_cxx_compiler_flag(${entry} flag_exists)
            if (flag_exists)
                if ("${writing_now}" STREQUAL "PRIVATE")
                    list(APPEND private_options ${entry})
                elseif ("${writing_now}" STREQUAL "PUBLIC")
                    list(APPEND public_options ${entry})
                elseif ("${writing_now}" STREQUAL "INTERFACE")
                    list(APPEND interface_options ${entry})
                else()
                    message(FATAL_ERROR "Unknown frameworks scope for target ${target_name}")
                endif()
            endif()
        endif()
    endforeach()

    if (NOT "${public_options}" STREQUAL "")
        target_link_options(${target_name} PUBLIC ${public_options})
    endif()
    if (NOT "${private_options}" STREQUAL "")
        target_link_options(${target_name} PRIVATE ${private_options})
    endif()
    if (NOT "${interface_options}" STREQUAL "")
        target_link_options(${target_name} INTERFACE ${interface_options})
    endif()
endfunction()
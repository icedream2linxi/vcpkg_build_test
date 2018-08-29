find_package(V8 REQUIRED)

message(STATUS "V8_INCLUDE_DIRS = ${V8_INCLUDE_DIRS}")
message(STATUS "V8_LIBRARIES = ${V8_LIBRARIES}")

find_package(ICU REQUIRED COMPONENTS i18n uc)

if (MSVC)
    set(DEPEND_LIBS Dbghelp.lib Shlwapi.lib Winmm.lib)
else()
    set(DEPEND_LIBS dl pthread)
endif()

add_executable(v8_hello_world hello-world.cc)
target_include_directories(v8_hello_world PRIVATE ${V8_INCLUDE_DIRS})
target_link_libraries(v8_hello_world PRIVATE ${V8_LIBRARIES} ${ICU_LIBRARIES} ${DEPEND_LIBS})

add_executable(v8_process process.cc)
target_include_directories(v8_process PRIVATE ${V8_INCLUDE_DIRS})
target_link_libraries(v8_process PRIVATE ${V8_LIBRARIES} ${ICU_LIBRARIES} ${DEPEND_LIBS})

add_executable(v8_shell shell.cc)
target_include_directories(v8_shell PRIVATE ${V8_INCLUDE_DIRS})
target_link_libraries(v8_shell PRIVATE ${V8_LIBRARIES} ${ICU_LIBRARIES} ${DEPEND_LIBS})
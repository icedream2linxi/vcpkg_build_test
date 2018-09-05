
set(ANTLR_JAR "${CMAKE_CURRENT_LIST_DIR}/antlr-4.7.1-complete.jar")
if (NOT EXISTS ${ANTLR_JAR})
    file(DOWNLOAD http://www.antlr.org/download/antlr-4.7.1-complete.jar ${ANTLR_JAR} SHOW_PROGRESS)
endif()

find_package(Java COMPONENTS Runtime REQUIRED)
add_custom_target(antlr4_generate_code
    COMMAND ${Java_JAVA_EXECUTABLE} -jar ${ANTLR_JAR} -Dlanguage=Cpp -listener -visitor -o generated/ -package antlrcpptest TLexer.g4 TParser.g4
    WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
)

find_file(ANTLR_INCLUDE_DIRS antlr4-runtime.h)
get_filename_component(ANTLR_INCLUDE_DIRS ${ANTLR_INCLUDE_DIRS} DIRECTORY)
find_library(ANTLR_LIBRARY_DEBUG antlr4-runtime ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/debug/lib NO_DEFAULT_PATH)
find_library(ANTLR_LIBRARY_RELEASE antlr4-runtime ${_VCPKG_INSTALLED_DIR}/${VCPKG_TARGET_TRIPLET}/lib NO_DEFAULT_PATH)
set(ANTLR_LIBRARIES debug "${ANTLR_LIBRARY_DEBUG}" optimized "${ANTLR_LIBRARY_RELEASE}")

message(STATUS "ANTLR_INCLUDE_DIRS = ${ANTLR_INCLUDE_DIRS}")
message(STATUS "ANTLR_LIBRARIES = ${ANTLR_LIBRARIES}")

file(GLOB SRCS generated/*.cpp)
list(APPEND SRCS main.cpp)
file(GLOB HDRS generated/*.h)
add_executable(antlr4_demo ${SRCS} ${HDRS})
target_include_directories(antlr4_demo PRIVATE ${ANTLR_INCLUDE_DIRS} "${CMAKE_CURRENT_LIST_DIR}/generated")
target_link_libraries(antlr4_demo PRIVATE ${ANTLR_LIBRARIES})
if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    target_link_libraries(antlr4_demo PRIVATE uuid)
endif()
add_dependencies(antlr4_demo antlr4_generate_code)
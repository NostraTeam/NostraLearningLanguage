cmake_minimum_required(VERSION 3.8.2 FATAL_ERROR)

find_package(FLEX)
find_package(BISON)

if(NOT FLEX_FOUND)
    message(ERROR "FLEX NOT FOUND!")
endif()

if(NOT BISON_FOUND)
    message(ERROR "BISON NOT FOUND!")
endif()

BISON_TARGET(Parser "input/parser.y" "${CMAKE_CURRENT_BINARY_DIR}/src/parser.cpp")
FLEX_TARGET(Lexer "input/lexer.l" "${CMAKE_CURRENT_BINARY_DIR}/src/lexer.cpp")

ADD_FLEX_BISON_DEPENDENCY(Lexer Parser)

add_executable(nllc "src/main.cpp" "${FLEX_Lexer_OUTPUTS}" "${BISON_Parser_OUTPUTS}")

target_include_directories(nllc PUBLIC "${CMAKE_CURRENT_BINARY_DIR}/src")
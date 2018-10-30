cmake_minimum_required(VERSION 3.8.2 FATAL_ERROR)

find_package(FLEX)

if(NOT FLEX_FOUND)
    message(ERROR "FLEX NOT FOUND!")
endif()

FLEX_TARGET(Lexer "input/lexer.l" "${CMAKE_CURRENT_BINARY_DIR}/src/lexer.cpp")

add_executable(nllc "src/main.cpp" "${FLEX_Lexer_OUTPUTS}")
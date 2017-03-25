cmake_minimum_required(VERSION 2.8.9)
project(out)
file(GLOB SOURCES "*.cpp")
add_executable(out ${SOURCES})
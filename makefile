.RECIPEPREFIX = |
.PHONY:  clean run setup generate_sources

#
# Builds the test/main.cc parser program for testing as an executable
#

CXX = g++
CINCL = -Isrc 
CXXFLAGS = -DDEBUG_ON -g -ggdb

SOURCES = $(shell find src -name *.cc) test/main.cc

all: setup generate_sources main.o

main.o: test/main.cc src/debug.h
| ${CXX} ${CXXFLAGS} ${CINCL} ${SOURCES} -o main.o

setup:

generate_sources:
| make -C src/lang/ansi-c all

clean:
| make -C src/lang/ansi-c clean
| rm -f main.o

run: all
| ./main.o -p -s test/sample_input/sample.c


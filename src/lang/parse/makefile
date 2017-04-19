.RECIPEPREFIX = |
.PHONY: all clean

all: parser.o
|@ echo "(done)"

parser.o: parser.cpp
| ${CXX} -c -o $@ ${CXXFLAGS} $^

clean:
| rm -f parser.o

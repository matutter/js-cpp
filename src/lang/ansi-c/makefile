.RECIPEPREFIX = |
.PHONY:  clean

name := ansi-c

all: lex.cc parse.cc
|@ echo "done"

lex.cc: ${name}.flex
| flex -vd ${name}.flex

parse.cc: ${name}.bison
| bison -vd ${name}.bison

clean:
| rm -f parse.hh parse.cc lex.cc lex.hh position.hh location.hh stack.hh parse.output

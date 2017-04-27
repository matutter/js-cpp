.RECIPEPREFIX = |
.PHONY: all clean

name := ansi-c

all: ${name}.yy.c ${name}.tab.c
|@ echo "done"

${name}.yy.c: ${name}.flex
| flex -vd ${name}.flex

${name}.tab.c: ${name}.bison
| bison -vd ${name}.bison

clean:
| rm -f ${name}.yy.hh ${name}.yy.cc ${name}.tab.cc ${name}.tab.hh ${name}.tab.bison ${name}.output position.hh location.hh stack.hh 

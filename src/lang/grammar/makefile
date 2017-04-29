.RECIPEPREFIX = |
.PHONY:  clean

name := ansi-c

all: ${name}.yy.cc ${name}.tab.cc
|@ echo "done"

${name}.yy.cc: ${name}.flex
| flex -vd ${name}.flex

${name}.tab.cc: ${name}.bison
| bison -vd ${name}.bison

clean:
| rm -f ${name}.yy.hh ${name}.yy.cc ${name}.tab.cc ${name}.tab.hh ${name}.tab.bison ${name}.output position.hh location.hh stack.hh 

.RECIPEPREFIX = |
.PHONY: all clean

name := ansi-c

all: ${name}.yy.c ${name}.tab.c
|@ echo "${name} parser generation (done)"

${name}.yy.c: ${name}.flex
| flex -vd ${name}.flex

${name}.tab.c: ${name}.bison
| bison -vd ${name}.bison

clean:
| rm -f ${name}.yy.h ${name}.yy.c ${name}.tab.c ${name}.tab.h ${name}.output

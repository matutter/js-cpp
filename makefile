.RECIPEPREFIX = |
.PHONY: all clean parser

src_d := $(abspath src)

CXXFLAGS := -I${src_d}

export CXXFLAGS

all: parser
|@ echo "(done)"

parser:
| make -C src/lang/parse

clean:
| make -C src/lang/parse clean

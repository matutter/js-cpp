
#include <stdio.h>


#define TWOLINE \
  "Two lines"

/**
* definition of macro1
*/
#define macro1(x, args… ) x


// definition of macro2
#define macro2(x,y, z) { \
  char* _x = x; \
  printf("%s %s %s", x, y, z); \
}


#define SOME_VAR1
#define SOME_VAR2 2
#define SOME_VAR3 "Hello world!"
#define SOME_VAR4 "Hello" \
" world!" 

int main(void) {
  printf("%s", SOME_VAR3);
}


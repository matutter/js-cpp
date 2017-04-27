#include <iostream>
#include "ansi-c.driver.hh"
#include "lang/grammar/ansi-c.tab.hh"


int main (int argc, char *argv[]) {
  int status = 0;
  AnsiCDriver driver;
  for (int i = 1; i < argc; ++i)
    if (argv[i] == std::string ("-p"))
      driver.trace_parsing = true;
    else if (argv[i] == std::string ("-s"))
      driver.trace_scanning = true;
    else if (!driver.parse (argv[i]))
      std::cout << driver.result << std::endl;
    else
      status = 1;
  return status;
}


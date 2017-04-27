/**
* Example from https://www.gnu.org/software/bison/manual/html_node/A-Complete-C_002b_002b-Example.html
*/

// The implementation of the driver is straightforward. The parse member
// function deserves some attention. The error functions are simple stubs, they
// should actually register the located error messages and set error state.

#include <string>
#include "ansi-c.driver.hh"
#include "lang/grammar/ansi-c.tab.hh"

AnsiCDriver::AnsiCDriver () : trace_scanning (false), trace_parsing (false) {
}

AnsiCDriver::~AnsiCDriver () {
}

int AnsiCDriver::parse (const std::string &f) {
  file = f;
  scan_begin ();
  yy::AnsiCParser parser (*this);
  parser.set_debug_level (trace_parsing);
  int res = parser.parse ();
  scan_end ();
  return res;
}

void AnsiCDriver::error (const yy::location& l, const std::string& m) {
  std::cerr << l << ": " << m << std::endl;
}

void AnsiCDriver::error (const std::string& m) {
  std::cerr << m << std::endl;
}


void AnsiCDriver::comment() {
  /*char c, c1;

  comment_loop:
    while ((c = input()) != '*' && c != 0) {
      putchar(c);
    }

    if ((c1 = input()) != '/' && c != 0) {
      unput(c1);
      goto comment_loop;
    }

    if (c != 0) {
      putchar(c1);
    }
    */
}



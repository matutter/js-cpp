/**
* Example from https://www.gnu.org/software/bison/manual/html_node/A-Complete-C_002b_002b-Example.html
*/

// The implementation of the driver is straightforward. The parse member
// function deserves some attention. The error functions are simple stubs, they
// should actually register the located error messages and set error state.

#include <string>
#include "debug.h"
#include "lang/ansi-c/driver.hh"
#include "lang/ansi-c/parse.hh"

AnsiCDriver::AnsiCDriver() : trace_scanning (false), trace_parsing (false) {}
AnsiCDriver::~AnsiCDriver() {}

int AnsiCDriver::parse(const std::string &f) {
  this->file = f;
  this->scan_begin();
  yy::AnsiCParser* parser = new yy::AnsiCParser(*this); 
  parser->set_debug_level(trace_parsing);
  this->result = parser->parse();
  scan_end();
  delete parser;
  return this->result;
}

void AnsiCDriver::error(const yy::location& l, const std::string& m) {
  debug_danger_cxx( l << ": " << m );
}

void AnsiCDriver::error(const std::string& m) {
  debug_danger_cxx(m);
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


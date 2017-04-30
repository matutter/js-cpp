
#ifndef ANSI_CXX_DRIVER_HH
#define ANSI_CXX_DRIVER_HH
#include <string>
#include <map>
#include "lang/ansi-c/parse.hh"
#include "lang/ansi-c/location.hh"

// Tell Flex the lexer's prototype ...
#define YY_DECL \
  yy::AnsiCParser::symbol_type yylex(AnsiCDriver& driver)
// ... and declare it for the parser's sake.
YY_DECL;

// Conducting the whole scanning and parsing of Calc++.
class AnsiCDriver {
public:
  AnsiCDriver ();
  virtual ~AnsiCDriver ();

  std::map<std::string, int> variables;

  int result;
  // To encapsulate the coordination with the Flex scanner,
  // it is useful to have member functions to open and close the scanning phase.
  // Handling the scanner.
  void scan_begin ();
  void scan_end ();
  void comment();
  bool trace_scanning;
  
  // Similarly for the parser itself.

  // Run the parser on file F.
  // Return 0 on success.
  int parse (const std::string& f);
  // The name of the file being parsed.
  // Used later to pass the file name to the location tracker.
  std::string file;
  // Whether parser traces should be generated.
  bool trace_parsing;
  // To demonstrate pure handling of parse errors, instead of simply dumping
  // them on the standard error output, we will pass them to the compiler driver
  // using the following two member functions. Finally, we close the class
  // declaration and CPP guard.

  // Error handling.
  void error (const yy::location& l, const std::string& m);
  void error (const std::string& m);
};
#endif 


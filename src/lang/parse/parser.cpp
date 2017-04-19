#include "lang/parse/parser.h"
#include "debug.h"
#include "types.h"

#include <string>

namespace cppjs {
  
  Parser::Parser() {
    debug_info("New Parser");
  };

  VOID Parser::scan_begin() {
    debug_info("Parser::scan_begin");
  }
  
  VOID Parser::scan_end() {
    debug_info("Parser::scan_end");
  }
  
  int Parser::parse(const std::string& input) {
    debug_info("Parser::parse");
    return 0;
  }
  
  int Parser::parseFile(const std::string& path) {
    debug_info("Parser::parseFile");
    return 0;
  }

  VOID Parser::error(const std::string& msg) {
    debug_danger("Parser::error")
  }

};



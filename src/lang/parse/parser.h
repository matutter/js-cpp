#include <string>

namespace cppjs {
  
  class Parser {

    public:
      Parser();
      virtual ~Parser();

      //std::map<std::string, int> variables;

      void scan_begin ();
      void scan_end ();
      bool trace_scanning;

      int parse(const std::string& input);
      int parseFile(const std::string& path);
      void error(const std::string& msg);

  };

};

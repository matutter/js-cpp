
class CppJsParser {
  
  public:
    CppJsParser();
    virtual ~CppJsParser();
  
    //std::map<std::string, int> variables;

    void scan_begin ();
    void scan_end ();
    bool trace_scanning;
  
    int parse(const std::string& input);
    int parseFile(const std::string& path);

};

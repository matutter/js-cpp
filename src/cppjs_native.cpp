#include <nan.h>
#include "types.h"
#include "debug.h"

#define DEBUG_ON

using namespace Nan;
using namespace v8;

namespace cppjs {

  NAN_METHOD(ParseString) {
    debug_info("ParseString")
    
    PCHAR buffer = (PCHAR) node::Buffer::Data(info[0]->ToObject());
    SIZE_T size = node::Buffer::Length(info[0]);

    PCHAR retval = new char[size];
    for(unsigned int i = 0; i < size; i++ ) {
      retval[i] = buffer[i] + 1;
    }
    
    info.GetReturnValue().Set(Nan::NewBuffer(retval, size).ToLocalChecked());
  }

  NAN_MODULE_INIT(ModuleInit) {
    
    debug_info("ModuleInit")

    Nan::Set(
      target,
      New<String>("parse").ToLocalChecked(),
      GetFunction(New<FunctionTemplate>(ParseString)).ToLocalChecked()
    );
  }

  NODE_MODULE(cppjs, ModuleInit)
}

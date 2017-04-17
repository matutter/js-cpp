const debug = require('debug')('cppjs')
var cppjsn;

if(process.env.DEBUG) {
  debug('Debug enabled | Loading native module')
  cppjsn = require('./build/Debug/cppjs_native');
} else {
  cppjsn = require('./build/Release/cppjs_native');
}
Object.freeze(cppjsn);

module.exports.parse = function(string, encoding) {
  var buffer = new Buffer(string, encoding || 'utf8');
  var result = cppjsn.parse( buffer );
  debug('parse', string, '=>', result.toString('utf8'))
  return result
}


module.exports.parse('1337')


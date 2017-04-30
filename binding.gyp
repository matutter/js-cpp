{
  "targets": [
    {
      "target_name": "cppjs_native",
      "sources": [ "src/cppjs_native.cpp" ],
      "include_dirs" : ["<!(node -e \"require('nan')\")"]
    }
  ]
}

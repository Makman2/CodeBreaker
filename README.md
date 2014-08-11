CodeBreaker
===========

CodeBreaker is a simple tool for writing JIT-compilers for other platforms.
It is compiled with Clang (x86 and x64) and CMake.




Reliability
-----------

This project tries to improve and maintain code quality and functionality with

* unit tests
* code checking utilities (planned)
* a continous build and test server (planned)




Infrastructure
--------------

There are several alternatives for the infrastructure to implement an effective
JIT-compiler:

1. Make a dynamic runtime frontend for LLVM (if LLVM supports this) that eats
   instructions and translates them to LLVM intermediate code. Let the virtual
   machine of LLVM do the rest.
   The problem: I didn't see that such dynamic frontends are supported, so this
   option is for now not possible.

2. Make own JIT-compiler (with presumely less good optimizations). Eat
   instructions, dispatch them to native functions (for now). Do some
   optimization with this (Invoke compiler to concat native functions
   together etc).

What both options share are the 'instruction-eater', to translate instructions
into target platform code. This mechanism is implemented in either way.

So for now this project chooses approach 2.




Code Style
----------

Code style guidelines can be found at [CODESTYLE.md](CODESTYLE.md).
They may change frequently because the project is in beginning phase.




Documentation
-------------

Documentation is generated with doxygen. It lays in [doc/](doc/).


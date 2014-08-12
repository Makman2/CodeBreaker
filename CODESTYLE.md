Codestyle for CodeBreaker
=========================

Used code standard: C++11 (aka C++0x).

Project namespace: CodeBreaker.


The code styles are defined in several paragraphs.

Note: Some code examples do not refer completely to this standard, they only
try to show what is meant in the enumeration.




General code style
------------------

* Space-Indentation with 4 spaces (TAB's are forbidden).

* Every line contains maximum 80 chars (+ line break CRLF).

* No right-trailing spaces.

* Camel-case naming is preferred when exposing to public.
  ```cpp
  int FooBarFunction();
  ```

* Every compilable code lays inside _.cpp_-files (even empty constructors or
  destructors), declarations only lay in _.h_-files and template-code in
  _.hpp_-files.

* Headers: No include guards, use instead `#pragma once`.

  This may change to keep the code everywhere compilable, but the target
  platforms of this project are high-performance cpu architectures that are
  supported by Clang and other common compilers.

* Scope blocks (enclosed with `{` and `}`) have it's own lines.
  ```cpp
  int Bar()
  { // bracket in separate line
      // ...
  } // and again own line
  ```

* Use `const` as much as you can!

* The includes are ordered in following way:
  ```cpp
  // System includes:
  #include <iostream>
  ...

  // CodeBreaker includes (everytime relative to CodeBreaker directory!)
  #include "CodeBreaker/core.h"
  ...

  // Other dependencies.
  ```




Classes
-------

* Class declarations reside in header files (_.h_).

* At least enclosed in `namespace CodeBreaker`.

* Because this is a library every destructor must be declared as virtual.

* Constructors can be leaved out if there are no members to be initialized.

* All class members must be initialized in initializer lists (see paragraph
  __member variables__).

* Classes are documented as follows:
  ```cpp
  /// @brief Short description.
  ///
  /// @details If needed, long description.
  ///
  /// @tparam T
  
  class Foo
  {
      // ...
  }
  ```

* No declaration stands outside an access modifier.
  The order of the access modifiers is:
  1. `private`
  2. `protected`
  3. `public`

  For example:
  ```cpp
  class Foo
  {
  private:
      // private fields.

  protected:
      // protected fields.

  public:
      // public fields.
  }
  ```




Functions
---------

* Function return type is a line above the name.
  ```cpp
  FooBarType
  bar();
  ```

* Function parameters are named C-style: Every letter is small and words are
  separated with '_' (numbers do not need an underline separator):
  ```cpp
  int FooBarFunction(int foo_param, int foo_param2, FooType bar2foo);
  ```

* `const` identifier comes _after_ the meant type:
  ```cpp
  int const* var; // A pointer to a const int.
  int* const var2; // A const pointer to a non-const int.
  ```
  __NOT ALLOWED__:
  ```cpp
  const int* var3; // A pointer to a const int.
  ```

* Every function declaration shall be documented with following style:
  ```cpp
  /// Short documentation.
  ///
  /// Detailed documentation.
  ///
  /// @tparam T Template parameter.
  /// @tparam ...
  /// @param P Function parameters.
  /// @param ...
  ```
  If functions returns value:
  ```cpp
  /// @returns Return value.
  ```

* If argument list of declarations are too long to fit in one line, they are
  table aligned like this:
  ```cpp
  FooBarType FooBarFunction(FooBarType const& foo_bar1,
                            FooBarType const& foo_bar2,
                            FooBarType        foo);
  ```




Member variables
----------------

* Documented in one line like
  ```cpp
  /// Short description of the member variable.
  ```
  If a detailed description is needed the documentation should look like
  ```cpp
  /// Short description.
  ///
  /// Long description.
  ```

* Member variable names are preceeded with ___m____ and the next letter is tall.
  For example:
  ```cpp
  int m_ANumber;
  ```

* Member variables are never `protected` nor `public`! To expose them to public
  you must write getters and setters.

* Every member variable of a class must be explicitly initialized in an
  initializer list. This looks like following:
  ```cpp
  Foo::Foo()
      : m_Variable1()
      , m_Variable2()
      , m_Variable3()
  {
      // ...
  }
  ```




Code sequences
--------------

* Multilinie sequences that doesn't fit into one line are splitted up into
  several lines, where following lines are space-indented. Points (`.`),
  dereference operators (`->`) and other special characters shall wrap to the
  next line:
  ```cpp
  int superlongvar = foo.bar().superlongfunc()
      .continues_here().and_does_something_else()
      ->and_so_on();
  ```

* Control statements (`for`, `if`, `while` etc): If braces content doesn't fit
  into one line, align the content to the first opening brace of the statement.
  Rules for line wrapping except the indentation are equal to first paragraph of
  __Code sequences__.
  For example:
  ```cpp
  for (int i = 0; i < foo.bar().superlongfunc()
       .continues_now_here(); i++)
  {
      // ...
  }
  ```

* Place __1__ space between control sequences and it's braces.
  ```cpp
  for (...)
  if (...)

  // This is wrong:
  for(...)
  while  (...)
  ```




Templates
---------

* Reside a line above declaration/definition.

  For classes:
  ```cpp
  template <typename T>
  class Foo
  {
      // ...
  }
  ```
  The same for functions:
  ```cpp
  template <typename T>
  void bar(T t);
  ```
* Double closing template argument braces: Add space between them.
  `template<template<typename T>>` should be `template<template<typename T> >`.

* Add space between `template` and `<`.
  ```cpp
  template<typename T> // Here isn't a space. WRONG!
  template <typename X> // OK, here is one.
  ```

* Try to use `typename` instead of `class` inside template arguments, because
  `class` means that the template argument must be a class! This is most time
  not intended.

* For template-meta-programming there are no rules to align everything
  good-looking, because such declarations/definitions are just too complicated
  to sort them readably. Do what you think looks good.




Tests
-----

Every class must be tested. The testing framework is not implemented now, but
more specs will come.




An example
----------
Example will follow.


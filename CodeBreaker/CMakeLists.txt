cmake_minimum_required(VERSION 2.8.12.2)

project(CodeBreaker)
SET(CodeBreaker_VERSION_MAJOR 0)
SET(CodeBreaker_VERSION_MINOR 0)
SET(CodeBreaker_VERSION_MICRO 1)

# No external packages used.
# To use, type:
# find_package(PACKAGENAME)

SET (CMAKE_CXX_FLAGS                "-std=c++11 -Wall -Werror -pedantic-errors")
SET (CMAKE_CXX_FLAGS_DEBUG          "-g")
SET (CMAKE_CXX_FLAGS_MINSIZEREL     "-Os -DNDEBUG")
SET (CMAKE_CXX_FLAGS_RELEASE        "-O4 -DNDEBUG")
SET (CMAKE_CXX_FLAGS_RELWITHDEBINGO "-O2 -g")
# Option description:
# -std=c++11: Language standard. Here: C++11.
# -pedantic-errors: Throw errors if the code doesn't conform the standard.
# -Wall: Enable all warnings.
# -Werror: Treat all warnings as errors.
# -pedantic-errors: Throw error on language extensions.
# -g: Compile with debug information.
# -Os: Optimize in size.
# -O2, -O4: Optimization levels.


# Define a custom include for this project for code files.
include_directories("${PROJECT_SOURCE_DIR}/..")

# === Add here subdirectories ==================================================
add_subdirectory ("codestream")
# ==============================================================================

add_library (CodeBreaker SHARED ${SRC})


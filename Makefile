# CodeBreaker main makefile.




# === Manual Configuration =====================================================

CC=$(shell which clang)
CXX=$(shell which clang++)

CODEBREAKER_SRC=CodeBreaker
CODEBREAKER_BUILD=build
CODEBREAKER_BUILD_DEBUG=$(CODEBREAKER_BUILD)/debug
CODEBREAKER_BUILD_RELEASE=$(CODEBREAKER_BUILD)/release

MAKE:=$(shell which make)
MAKE_FLAGS=--no-print-directory

CMAKE:=$(shell which cmake)
CMAKE_FLAGS=-DCMAKE_C_COMPILER=$(CC) -DCMAKE_CXX_COMPILER=$(CXX)
CMAKE_DEBUG_FLAGS=-DCMAKE_BUILD_TYPE=debug
CMAKE_RELEASE_FLAGS=-DCMAKE_BUILD_TYPE=release

# IDE project generator configurations.
CMAKE_IDE_PATH=ide

CMAKE_IDE_ECLIPSE_PATH=$(CMAKE_IDE_PATH)/eclipse
CMAKE_IDE_ECLIPSE_GENERATOR_FLAGS=-G "Eclipse CDT4 - Unix Makefiles"
CMAKE_IDE_ECLIPSE_FLAGS=

# ==============================================================================




# Determines pathdepth and creates revert path (/..) for using in other paths.
CODEBREAKER_BUILD_DEBUG_SLASHMATCH=\
    $(shell echo $(CODEBREAKER_BUILD_DEBUG) | grep -o / | wc -l)
CODEBREAKER_BUILD_DEBUG_PATHDEPTH=\
    $(shell echo $(CODEBREAKER_BUILD_DEBUG_SLASHMATCH)+1 | bc)

CODEBREAKER_BUILD_DEBUG_REVERTPATH:=$(shell \
echo -n ".." ;                                                      \
i=2 ; while [[ $$i -le $(CODEBREAKER_BUILD_DEBUG_PATHDEPTH) ]] ; do \
	echo -n "/.." ;                                                 \
	((i = i + 1)) ;                                                 \
done                                        \
)

# Determines pathdepth and creates revert path (/..) for using in other paths.
CODEBREAKER_BUILD_RELEASE_SLASHMATCH=\
    $(shell echo $(CODEBREAKER_BUILD_RELEASE) | grep -o / | wc -l)
CODEBREAKER_BUILD_RELEASE_PATHDEPTH=\
    $(shell echo $(CODEBREAKER_BUILD_RELEASE_SLASHMATCH)+1 | bc)

CODEBREAKER_BUILD_RELEASE_REVERTPATH:=$(shell \
echo -n ".." ;                                                        \
i=2 ; while [[ $$i -le $(CODEBREAKER_BUILD_RELEASE_PATHDEPTH) ]] ; do \
	echo -n "/.." ;                                                   \
	((i = i + 1)) ;                                                   \
done                                          \
)

# Pathdepth for IDE - Eclipse
CMAKE_IDE_ECLIPSE_PATH_SLASHMATCH=\
    $(shell echo $(CMAKE_IDE_ECLIPSE_PATH) | grep -o / | wc -l)
CMAKE_IDE_ECLIPSE_PATHDEPTH=\
    $(shell echo $(CODEBREAKER_BUILD_RELEASE_SLASHMATCH)+1 | bc)

CMAKE_IDE_ECLIPSE_REVERTPATH:=$(shell \
echo -n ".." ;                                                        \
i=2 ; while [[ $$i -le $(CMAKE_IDE_ECLIPSE_PATHDEPTH) ]] ; do         \
	echo -n "/.." ;                                                   \
	((i = i + 1)) ;                                                   \
done                                  \
)

# Construct relative sources.
CODEBREAKER_RELATIVE_SRC_DEBUG=\
    $(CODEBREAKER_BUILD_DEBUG_REVERTPATH)/$(CODEBREAKER_SRC)
CODEBREAKER_RELATIVE_SRC_RELEASE=\
    $(CODEBREAKER_BUILD_RELEASE_REVERTPATH)/$(CODEBREAKER_SRC)

CMAKE_IDE_ECLIPSE_RELATIVE_PATH_TO_SRC=\
    $(CMAKE_IDE_ECLIPSE_REVERTPATH)/$(CODEBREAKER_SRC)



help:
	@echo "CodeBreaker main makefile."
	@echo
	@echo "Target       Description"
	@echo "--------------------------------------------------------------------"
	@echo "[help]         Default. Prints this help."
	@echo
	@echo "debug          Performs debug build."
	@echo
	@echo "release        Performs release build."
	@echo
	@echo "clean          Cleans all temporary and build files."
	@echo
	@echo "clean-debug    Cleans all temporary and build files for debug"
	@echo "               configuration"
	@echo
	@echo "clean-release  Cleans all temporary and build files for release"
	@echo "               configuration."
	@echo
	@echo "print          Makefile debug target, displays the values of the"
	@echo "               variables in this makefile."
	@echo
	@echo "IDE-eclipse    Generates a project for the Eclipse IDE from source."
	@echo

debug:
ifeq ($(wildcard $(CODEBREAKER_BUILD_DEBUG)),)
	@echo -n "Creating debug directory ($(CODEBREAKER_BUILD_DEBUG))... "
	@mkdir -p $(CODEBREAKER_BUILD_DEBUG)
	@echo "DONE"
endif
	@cd $(CODEBREAKER_BUILD_DEBUG) ; \
	$(CMAKE) $(CODEBREAKER_RELATIVE_SRC_DEBUG) \
	         $(CMAKE_FLAGS) $(CMAKE_DEBUG_FLAGS)
	@echo "Building... "
	@$(MAKE) $(MAKE_FLAGS) -C $(CODEBREAKER_BUILD_DEBUG)
	@echo "DONE"

release:
ifeq ($(wildcard $(CODEBREAKER_BUILD_RELEASE)),)
	@echo -n "Creating release directory ($(CODEBREAKER_BUILD_RELEASE))... "
	@mkdir -p $(CODEBREAKER_BUILD_RELEASE)
	@echo "DONE"
endif
	@cd $(CODEBREAKER_BUILD_RELEASE) ; \
	$(CMAKE) $(CODEBREAKER_RELATIVE_SRC_RELEASE) \
	         $(CMAKE_FLAGS) $(CMAKE_RELEASE_FLAGS)
	@echo "Building... "
	@$(MAKE) $(MAKE_FLAGS) -C $(CODEBREAKER_BUILD_RELEASE)
	@echo "DONE"

clean:
	@echo -n "Removing build directories... "
	@rm -rf $(CODEBREAKER_BUILD)
	@echo "DONE"

clean-debug:
	@echo -n "Removing build directory for debug configuration... "
	@rm -rf $(CODEBREAKER_BUILD_DEBUG)
	@echo "DONE"

clean-release:
	@echo -n "Removing build directory for release configuration... "
	@rm -rf $(CODEBREAKER_BUILD_RELEASE)
	@echo "DONE"

IDE-eclipse:
ifeq ($(wildcard $(CMAKE_IDE_ECLIPSE_PATH)),)
	@echo -n "Creating directory ($(CMAKE_IDE_ECLIPSE_PATH))... "
	@mkdir -p $(CMAKE_IDE_ECLIPSE_PATH)
	@echo "DONE"
endif
	@echo "Generating project for IDE: Eclipse... "
	@cd $(CMAKE_IDE_ECLIPSE_PATH) ; \
	$(CMAKE) $(CMAKE_IDE_ECLIPSE_RELATIVE_PATH_TO_SRC) \
	         $(CMAKE_IDE_ECLIPSE_GENERATOR_FLAGS) \
	         $(CMAKE_IDE_ECLIPSE_FLAGS)
	@echo "DONE"
	@echo "# Project files for IDE Eclipse written to:"
	@echo "# $(CMAKE_IDE_ECLIPSE_PATH)."

print:
	@echo "CC:"
	@echo "$(CC)"
	@echo "CXX:"
	@echo "$(CXX)"
	@echo "CODEBREAKER_SRC:"
	@echo "$(CODEBREAKER_SRC)"
	@echo "CODEBREAKER_BUILD_BUILD:"
	@echo "$(CODEBREAKER_BUILD)"
	@echo "CODEBREAKER_BUILD_DEBUG:"
	@echo "$(CODEBREAKER_BUILD_DEBUG)"
	@echo "CODEBREAKER_BUILD_RELEASE:"
	@echo "$(CODEBREAKER_BUILD_RELEASE)"
	@echo "MAKE:"
	@echo "$(MAKE)"
	@echo "MAKE_FLAGS:"
	@echo "$(MAKE_FLAGS)"
	@echo "CMAKE:"
	@echo "$(CMAKE)"
	@echo "CMAKE_FLAGS:"
	@echo "$(CMAKE_FLAGS)"
	@echo "CMAKE_DEBUG_FLAGS:"
	@echo "$(CMAKE_DEBUG_FLAGS)"
	@echo "CMAKE_RELEASE_FLAGS:"
	@echo "$(CMAKE_RELEASE_FLAGS)"
	@echo "CODEBREAKER_BUILD_DEBUG_SLASHMATCH:"
	@echo "$(CODEBREAKER_BUILD_DEBUG_SLASHMATCH)"
	@echo "CODEBREAKER_BUILD_DEBUG_PATHDEPTH:"
	@echo "$(CODEBREAKER_BUILD_DEBUG_PATHDEPTH)"
	@echo "CODEBREAKER_BUILD_DEBUG_REVERTPATH:"
	@echo "$(CODEBREAKER_BUILD_DEBUG_REVERTPATH)"
	@echo "CODEBREAKER_BUILD_RELEASE_SLASHMATCH:"
	@echo "$(CODEBREAKER_BUILD_RELEASE_SLASHMATCH)"
	@echo "CODEBREAKER_BUILD_RELEASE_PATHDEPTH:"
	@echo "$(CODEBREAKER_BUILD_RELEASE_PATHDEPTH)"
	@echo "CODEBREAKER_BUILD_RELEASE_REVERTPATH:"
	@echo "$(CODEBREAKER_BUILD_RELEASE_REVERTPATH)"
	@echo "CODEBREAKER_RELATIVE_SRC_DEBUG:"
	@echo "$(CODEBREAKER_RELATIVE_SRC_DEBUG)"
	@echo "CODEBREAKER_RELATIVE_SRC_RELEASE:"
	@echo "$(CODEBREAKER_RELATIVE_SRC_RELEASE)"
	@echo "CMAKE_IDE_PATH:"
	@echo "$(CMAKE_IDE_PATH)"
	@echo "CMAKE_IDE_ECLIPSE_PATH:"
	@echo "$(CMAKE_IDE_ECLIPSE_PATH)"
	@echo "CMAKE_IDE_ECLIPSE_GENERATOR_FLAGS:"
	@echo "$(CMAKE_IDE_ECLIPSE_GENERATOR_FLAGS)"
	@echo "CMAKE_IDE_ECLIPSE_FLAGS:"
	@echo "$(CMAKE_IDE_ECLIPSE_FLAGS)"
	@echo "CMAKE_IDE_ECLIPSE_PATH_SLASHMATCH:"
	@echo "$(CMAKE_IDE_ECLIPSE_PATH_SLASHMATCH)"
	@echo "CMAKE_IDE_ECLIPSE_PATHDEPTH:"
	@echo "$(CMAKE_IDE_ECLIPSE_PATHDEPTH)"
	@echo "CMAKE_IDE_ECLIPSE_REVERTPATH:"
	@echo "$(CMAKE_IDE_ECLIPSE_REVERTPATH)"
	@echo "CMAKE_IDE_ECLIPSE_RELATIVE_PATH_TO_SRC:"
	@echo "$(CMAKE_IDE_ECLIPSE_RELATIVE_PATH_TO_SRC)"


# Makefile used to build and test protobuf-delphi
## Requires sh and .NET Core CLI

.DEFAULT_GOAL := test

# Makefile support code

## Disable built-in rules and variables
MAKEFLAGS += --no-builtin-rules
MAKEFLAGS += --no-builtin-variables
## Require sh for recipes
SHELL = sh
## Platform abstraction
#### create-folder: Create folder $(1) and its ancestors if it does not exit
create-folder = mkdir -p $(1)
#### remove-folder: Remove folder $(1)
remove-folder = rm -rf $(1)
## Empty string
EMPTY =
## Space character
SPACE = $(EMPTY) $(EMPTY)
## Comma character
COMMA = ,
#### join-string: Join strings $(1) with separator $(2)
join-string = $(subst $(SPACE),$(2),$(strip $(1)))
#### install-dot-net-tool: Install .NET Core global tool $(1) with version $(2)
install-dot-net-tool = dotnet tool update --global $(1) --version $(2)

# Configuration

## Source folder
SRC = source
## Source Delphi unit folders
SRC_UNIT_FOLDERS =
## Runtime library sources
SRC_UNIT_FOLDERS += $(SRC)/Com/GitHub/Pikaju/Protobuf/Delphi
## Common runtime-independent sources to support protoc-gen-delphi
SRC_UNIT_FOLDERS += $(SRC)/Work/Connor/Protobuf/Delphi/ProtocGenDelphi
## Protoc-gen-delphi public API sources
SRC_UNIT_FOLDERS += $(SRC)/Work/Connor/Protobuf/Delphi/ProtocGenDelphi/Runtime
## Protoc-gen-delphi internal API sources
SRC_UNIT_FOLDERS += $(SRC)/Work/Connor/Protobuf/Delphi/ProtocGenDelphi/Runtime/Internal
## Source Delphi units
SRC_UNITS += $(foreach folder,$(SRC_UNIT_FOLDERS),$(wildcard $(folder)/*.pas))
## Source Delphi include folders
SRC_INCLUDE_FOLDERS =
## Helper include files for the Work.Connor namespace
SRC_INCLUDE_FOLDERS += $(SRC)/Work/Connor/Delphi
## Source Delphi include files
SRC_INCLUDE_FILES += $(foreach folder,$(SRC_INCLUDE_FOLDERS),$(wildcard $(folder)/*.inc))
## Test source folder
TEST_SRC = test
## Test source Delphi unit folders
TEST_SRC_UNIT_FOLDERS =
## Unit test utility sources
TEST_SRC_UNIT_FOLDERS += $(TEST_SRC)/utility
## Unit test sources
TEST_SRC_UNIT_FOLDERS += $(TEST_SRC)/unit
## Unit test message example sources
TEST_SRC_UNIT_FOLDERS += example
## Test source Delphi units
TEST_SRC_UNITS += $(foreach folder,$(TEST_SRC_UNIT_FOLDERS),$(wildcard $(folder)/*.pas))
## Unit test runner program source
UNIT_TEST_RUNNER_SRC = $(TEST_SRC)/unit/Com.GitHub.Pikaju.Protobuf.Delphi.Test.ProtobufUnitTestRunner.pas
## Build output folder
BUILD = build
## Unit test runner program
UNIT_TEST_RUNNER = $(BUILD)/test-runner
## FPC message numbers to suppress
FPC_SUPPRESSED_MESSAGES +=
# Unit not used (Inconvenient for copying files from stub runtime API)
FPC_SUPPRESSED_MESSAGES += 5023
# Parameter not used (API should not be affected by implementation choice)
FPC_SUPPRESSED_MESSAGES += 5024
## Constructing a class with abstract method (generics.collections.pas)
FPC_SUPPRESSED_MESSAGES += 4046
## Range check error while evaluating constants (generics.collections.pas)
FPC_SUPPRESSED_MESSAGES += 4110
## Function result does not seem to be set (generics.collections.pas)
FPC_SUPPRESSED_MESSAGES += 5033
## Private type never used (generics.collections.pas)
FPC_SUPPRESSED_MESSAGES += 5071
## Found abstract method (generics.collections.pas)
FPC_SUPPRESSED_MESSAGES += 5062
## Local variable of a managed type does not seem to be initialized (generics.collections.pas)
FPC_SUPPRESSED_MESSAGES += 5091
## Function result variable of a managed type does not seem to be initialized (generics.collections.pas)
FPC_SUPPRESSED_MESSAGES += 5093
## Calls to subrotuines marked as inline are not inlined (generics.collections.pas)
FPC_SUPPRESSED_MESSAGES += 6058
## FPC options
FPC_OPTIONS += -vm$(call join-string,$(FPC_SUPPRESSED_MESSAGES),$(COMMA))
## Halt on warnings, notes and hints
FPC_OPTIONS += -Sewnh
#### compile: Build program $(1) from Pascal source $(2), unit paths $(3), include paths $(4) and output directory $(5)
compile = fpc -vq $(FPC_OPTIONS) -o$(1) -FE$(5) $(addprefix -Fu,$(3)) $(addprefix -Fi,$(4)) $(2)
## protoc-gen-delphi plug-in name
PLUGIN = protoc-gen-delphi
## protoc-gen-delphi version
PLUGIN_VERSION = 0.9.3
## Integration test tool name
INTEGRATION_TEST_TOOL = protoc-gen-delphi.runtime-tests
## Integration test tool executable name
INTEGRATION_TEST_TOOL_EXECUTABLE = protoc-gen-delphi-runtime-tests

# Targets

## Test runner program
.PHONY: unit-tests
unit-tests: $(UNIT_TEST_RUNNER)
$(UNIT_TEST_RUNNER): $(SRC_UNITS) $(SRC_INCLUDE_FILES) $(TEST_SRC_UNITS)
	$(call create-folder,$(BUILD))
	$(call compile,$(UNIT_TEST_RUNNER),$(UNIT_TEST_RUNNER_SRC),$(SRC_UNIT_FOLDERS) $(TEST_SRC_UNIT_FOLDERS),$(SRC_INCLUDE_FOLDERS),$(BUILD))

## Run unit tests
.PHONY: run-unit-tests
run-unit-tests: $(UNIT_TEST_RUNNER)
	$(UNIT_TEST_RUNNER)

## Install the protoc-gen-delphi plug-in
.PHONY: plugin
plugin:
	$(call install-dot-net-tool,$(PLUGIN),$(PLUGIN_VERSION))

## Install the integration test tool
.PHONY: integration-tests
integration-tests:
	$(call install-dot-net-tool,$(INTEGRATION_TEST_TOOL),$(PLUGIN_VERSION))

## Run integration tests
.PHONY: run-integration-tests
run-integration-tests: plugin integration-tests
	Work_Connor_Protobuf_Delphi_ProtocGenDelphi_RuntimeTests_RuntimeLibrarySourcePath=$$(pwd)/source $(INTEGRATION_TEST_TOOL_EXECUTABLE)

## Run all tests
.PHONY: test
test: run-unit-tests run-integration-tests

## Clean all targets
.PHONY: clean
clean:
	$(call remove-folder,$(BUILD))

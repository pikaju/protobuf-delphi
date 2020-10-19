# Makefile used to build and test protobuf-delphi
## Requires sh and .NET Core CLI

.DEFAULT_GOAL := test

# Makefile support code

## Disable built-in rules and variables
MAKEFLAGS += --no-buitin-rules
MAKEFLAGS += --no-buitin-variables
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
## Public runtime sources
SRC_UNIT_FOLDERS += $(SRC)/Com/GitHub/Pikaju/Protobuf/Delphi
## Internal runtime sources
SRC_UNIT_FOLDERS += $(SRC)/Com/GitHub/Pikaju/Protobuf/Delphi/Internal
## Common runtime-independent sources to support protoc-gen-delphi
SRC_UNIT_FOLDERS += $(SRC)/Work/Connor/Protobuf/Delphi/ProtocGenDelphi
## Source Delphi units
SRC_UNITS += $(foreach folder,$(SRC_UNIT_FOLDERS),$(wildcard $(folder)/*.pas))
## Test source folder
TEST_SRC = test
## Test source Delphi unit folders
TEST_SRC_UNIT_FOLDERS =
## Unit test sources
TEST_SRC_UNIT_FOLDERS += $(TEST_SRC)/unit
## Unit test sources for codecs
TEST_SRC_UNIT_FOLDERS += $(TEST_SRC)/unit/codecs
## Unit test utility sources
TEST_SRC_UNIT_FOLDERS += $(TEST_SRC)/utility
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
#### compile: Build program $(1) from Pascal source $(2) and unit paths $(3) and output directory $(4)
compile = fpc -vq $(FPC_OPTIONS) -o$(1) -FE$(4) $(addprefix -Fu,$(3)) $(2)
## protoc-gen-delphi plug-in name
PLUGIN = protoc-gen-delphi
## protoc-gen-delphi version
PLUGIN_VERSION = 0.3.0
## Integration test tool name
INTEGRATION_TEST_TOOL = protoc-gen-delphi.runtime-tests
## Integration test tool executable name
INTEGRATION_TEST_TOOL_EXECUTABLE = protoc-gen-delphi-runtime-tests

# Targets

## Test runner program
.PHONY: unit-tests
unit-tests: $(UNIT_TEST_RUNNER)
$(UNIT_TEST_RUNNER): $(SRC_UNITS) $(TEST_SRC_UNITS)
	$(call create-folder,$(BUILD))
	$(call compile,$(UNIT_TEST_RUNNER),$(UNIT_TEST_RUNNER_SRC),$(SRC_UNIT_FOLDERS) $(TEST_SRC_UNIT_FOLDERS),$(BUILD))

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

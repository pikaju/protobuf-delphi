OUT_DIR=build/
UNIT_DIR=source/unit/

COMPILER=fpc
CFLAGS=-FE$(OUT_DIR) -Fu$(UNIT_DIR)

.DEFAULT_GOAL := test

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

build: clean $(OUT_DIR)
	$(COMPILER) $(CFLAGS) tests/Protobuf.Test.TestRunner.pas

test: build
	./build/Protobuf.Test.TestRunner

clean:
	rm -rf build/
OUT_DIR=build/
UNIT_DIR=source/unit/

COMPILER=fpc
CFLAGS=-FE$(OUT_DIR) -Fu$(UNIT_DIR)

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

build: clean $(OUT_DIR)
	$(COMPILER) $(CFLAGS) tests/TestRunner.pas

test: build
	./build/TestRunner

clean:
	rm -rf build/
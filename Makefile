OUT_DIR=./build/

COMPILER=fpc
CFLAGS=-FE$(OUT_DIR) -Fusource/unit/ -Fusource/unit/codecs/ -Futests/unit/ -Futests/unit/codecs/

PROGRAM_FILE_NAME=Com.GitHub.Pikaju.Protobuf.Delphi.Test.ProtobufTestRunner

.DEFAULT_GOAL := test

$(OUT_DIR):
	mkdir -p $(OUT_DIR)

build: clean $(OUT_DIR)
	$(COMPILER) $(CFLAGS) ./tests/$(PROGRAM_FILE_NAME).pas

test: build
	./build/$(PROGRAM_FILE_NAME)

clean:
	rm -rf build/

ZIG = /home/john/bin/zig
TARGET = libcolumnar.so
SRCS = columnar.zig

all: $(TARGET)

$(TARGET): $(SRCS)
	$(ZIG) build-lib -O ReleaseFast -dynamic $(SRCS) -femit-bin=$(TARGET)

clean:
	rm -f $(TARGET) *.o

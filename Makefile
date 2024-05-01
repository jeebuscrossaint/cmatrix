ZIG_SOURCE = matrix.zig
ZIG_BINARY = matrix
ZIG_WASTE = matrix.exe matrix.exe.obj matrix.pdb

.PHONY: all clean run
all: $(ZIG_BINARY)

$(ZIG_BINARY): $(ZIG_SOURCE)
	zig build-exe -lc $(ZIG_SOURCE)
	
clean:
	rm -f $(ZIG_WASTE)

run: $(ZIG_BINARY)
	./$(ZIG_BINARY)
CC:=gcc
LD:=gcc
CFLAGS=-Wall -pedantic
LDFLAGS=-fPIC
debug : CFLAGS+=-g
release : CFLAGS+=-O3
release : LDFLAGS+=-O3
srcdir  := src
builddir  := build
outdir  := bin
SOURCES  := $(shell find $(srcdir) -name "*.c")
OBJS := $(SOURCES:$(srcdir)/%.c=$(builddir)/%.o)
DEPS := $(SOURCES:$(srcdir)/%.c=$(builddir)/%.d)
DIR  := $(shell find src -type d -printf "build/%P\0" | xargs -0 mkdir -p)
TARGET  := $(outdir)/main

all: release
release: $(TARGET)
debug: $(TARGET)

$(TARGET): $(OBJS)
	@mkdir  -p bin
	@echo "Building bin/main"
	@$(LD) $+ $(LDFLAGS) -o $@
build/%.o: src/%.c build/%.d
	@mkdir  -p $(dir $@)
	@echo "Building $@"
	@$(CC) $< $(CFLAGS) -c -o $@
build/%.d: src/%.c
	@mkdir  -p $(dir $@)
	@$(CC) $< -MP -MM | sed 's=\($*\)\.o[ :]*=$(@D)/\1.o $@ : =g'> $@

clean:
	@rm -rf $(OBJS) $(DEPS) $(TARGET)
	@find build -depth -type d -exec rmdir {} + 2> /dev/null || true
	-@rmdir bin  build 2> /dev/null || true
.PHONY: clean  all  release  debug
.SECONDARY: $(OBJS) $(DEPS)
-include $(DEPS)
#Łukasz Wroński

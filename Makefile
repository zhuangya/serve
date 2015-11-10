PROG = serve
SOURCES = $(PROG).c mongoose.c $(wildcard deps/*/*.c)
CFLAGS = -Ideps -std=c99 -W -Wall -pthread $(CFLAGS_EXTRA)

ifeq ($(OS), Windows_NT)
else
  UNAME_S := $(shell uname -s)
  ifeq ($(UNAME_S), Linux)
    CFLAGS += -ldl -lm
  endif
endif

all: clean $(PROG)

$(PROG): $(SOURCES)
	@mkdir -p dest
	$(CC) $(SOURCES) -o dest/$@ $(CFLAGS)

$(PROG).exe: $(SOURCES)
	cl $(SOURCES) /I.. /MD /Fe$@

clean:
	rm -rf *.gc* *.dSYM *.exe *.obj *.o a.out $(PROG)

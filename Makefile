OBJS = cell.o field.o board.o escape.o mine.o


mine: ${OBJS}
	gnatbind mine
	gnatlink mine

install: mine
	install -p -m755 mine ~/.local/bin/

%.o: src/%.adb
	gnat compile $<

src/%.adb: src/%.prep.adb prep.def
	gnatprep $< $@ prep.def

.PHONY: clean
clean:
	rm -f *.ali *.o mine *.tar.zst
	rm -rf pkg/

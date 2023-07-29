OBJS = cell.o field.o board.o escape.o mine.o



default: mine
	cp -f mine ../

install: mine
	cp -f mine ~/.local/bin/

mine: ${OBJS}
	gnatbind mine
	gnatlink mine

%.o: %.adb %.ads
	gnat compile $<

%.o: %.adb
	gnat compile $<

%.adb: %.prep.adb prep.def
	gnatprep $< $@ prep.def

.PHONY: clean
clean:
	rm -f *.ali *.o mine

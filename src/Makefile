OBJS = cell.o field.o board.o mine.o

default: mine
	cp mine ../

mine: ${OBJS}
	gnatbind mine
	gnatlink mine

%.o: %.adb
	gnat compile $<


%.adb: %.unprepped.adb
	gnatprep $< $@ prep.def

.PHONY: clean
clean:
	rm -f *.ali *.o mine

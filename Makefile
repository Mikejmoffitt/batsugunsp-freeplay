AS=asl
P2BIN=p2bin
SRC=patch.a68
BSPLIT=bsplit
MAME=mame

ASFLAGS=-i . -n -U

.PHONY: tp030-sp.u69

all: tp030-sp.u69

prg.o:
	$(AS) $(SRC) $(ASFLAGS) -o prg.o

tp030-sp.u69: prg.o
	$(P2BIN) $< prg.bin -r \$$-0x7FFFF
	$(BSPLIT) x prg.bin $@
	rm prg.o
	rm prg.bin

test: tp030-sp.u69
	mkdir -p ~/.mame/roms/batsugunsp/
	cp $< ~/.mame/roms/batsugunsp/
	$(MAME) -debug batsugunsp

clean:
	@-rm -f prg.bin
	@-rm -f prg.o

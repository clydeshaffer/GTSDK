AS = vasm6502_oldstyle
AFLAGS = -dotdir -wdc02 -Fbin

BUILDDIR = build

GAMENAME = "MyGame"

ASMOBJS = $(wildcard src/*.asm)

_BMPOBJS = $(wildcard assets/*.bmp)
BMPOBJS = $(patsubst %.bmp,$(BUILDDIR)/assets/%.gtg.deflate,$(_BMPOBJS))

bin/$(GAMENAME).gtr: $(ASMOBJS) $(BMPOBJS)
	$(AS) $(AFLAGS) -o $(GAMENAME).gtr src/main.asm

$(BUILDDIR)/assets/%.deflate: $(BUILDDIR)/%
	mkdir -p $(@D)
	zopfli --deflate $<

$(BUILDDIR)/assets/%.gtg: assets/%.bmp
	mkdir -p $(@D)
	cd scripts ;\
	node sprite_convert.js ../$< ../$@

clean:
	rm -rf bin
	rm -rf build

setup:
	cd scripts ;\
	npm install
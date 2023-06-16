CC = cc65
AS = ca65
LN = ld65

FLASHTOOL = ~/repos/GTFO/bin/GTFO.exe

SDIR = src
ODIR = build

PORT = COM3

CFLAGS = -t none -Osr --cpu 65c02 --codesize 500 --static-locals
AFLAGS = --cpu 65C02 --bin-include-dir lib --bin-include-dir $(ODIR)/assets
LFLAGS = -C gametank-2M.cfg -m $(ODIR)/out.map -vm
LLIBS = lib/gametank.lib

_COBJS = globals.o gametank.o dynawave.o drawing_funcs.o tilemap.o random.o music.o enemies.o level.o banking.o main.o
COBJS = $(patsubst %,$(ODIR)/%,$(_COBJS))
_AOBJS = assets.o wait.o vectors.o interrupt.o draw_util.o enemy_util.o
AOBJS = $(patsubst %,$(ODIR)/%,$(_AOBJS))

_BMPOBJS = gamesprites.gtg.deflate
BMPOBJS = $(patsubst %,$(ODIR)/assets/%,$(_BMPOBJS))

_SPRITEMETA = gamesprites.gsi
SPRITEMETA = $(patsubst %,$(ODIR)/assets/%,$(_SPRITEMETA))

_AUDIO_FW = audio_fw.bin.deflate
AUDIO_FW = $(patsubst %,$(ODIR)/assets/%,$(_AUDIO_FW))

_MUSIC = title.gtm2
MUSIC = $(patsubst %,$(ODIR)/assets/%,$(_MUSIC))

_BANKS = bank00 filler bank7F
BANKS = $(patsubst %,bin/fiend.gtr.%,$(_BANKS))

bin/fiend.gtr: $(BANKS)
	cat $(BANKS) > $@

 $(BANKS): $(AOBJS) $(COBJS) $(LLIBS) gametank-2M.cfg
	mkdir -p $(@D)
	$(LN) $(LFLAGS) $(AOBJS) $(COBJS) -o bin/fiend.gtr $(LLIBS)

$(ODIR)/assets.o: src/assets.s $(BMPOBJS) $(SPRITEMETA) $(AUDIO_FW) $(MUSIC)
	mkdir -p $(@D)
	$(AS) $(AFLAGS) -o $@ $<

$(ODIR)/%.si: src/%.c src/%.h
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ $<

$(ODIR)/%.si: src/%.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) -o $@ $<

$(ODIR)/%.o: $(ODIR)/%.si
	mkdir -p $(@D)
	$(AS) $(AFLAGS) -o $@ $<

$(ODIR)/%.o: src/%.s
	mkdir -p $(@D)
	$(AS) $(AFLAGS) -o $@ $<

lib/gametank.lib: src/crt0.s
	$(AS) src/crt0.s -o build/crt0.o
	ar65 a lib/gametank.lib build/crt0.o

$(ODIR)/assets/%.gtg: assets/%.bmp
	mkdir -p $(@D)
	cd scripts ;\
	node sprite_convert.js ../$< ../$@

$(ODIR)/assets/%.gtm2: assets/%.mid
	mkdir -p $(@D)
	cd scripts ;\
	node midiconvert.js ../$< ../$@

$(ODIR)/assets/%.deflate: $(ODIR)/assets/%
	mkdir -p $(@D)
	zopfli --deflate $<

$(ODIR)/assets/%.gsi: assets/%.json
	mkdir -p $(@D)
	cd scripts ;\
	node sprite_metadata.js ../$< ../$@

$(ODIR)/assets/audio_fw.bin.deflate: $(ODIR)/assets/audio_fw.bin
	zopfli --deflate $<

$(ODIR)/assets/audio_fw.bin: src/audio_fw.asm gametank-acp.cfg
	$(AS) --cpu 65C02 src/audio_fw.asm -o $(ODIR)/assets/audio_fw.o
	$(LN) -C gametank-acp.cfg $(ODIR)/assets/audio_fw.o -o $(ODIR)/assets/audio_fw.bin

.PHONY: clean

clean:
	rm -rf $(ODIR)/*

flash: $(BANKS)
	$(FLASHTOOL) bin/fiend.gtr.bank*

emulate:
	../GameTankEmulator/bin/$(OS)/GameTankEmulator bin/fiend.gtr

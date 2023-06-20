CC = cc65
AS = ca65
LN = ld65

TARGET=game.gtr

FLASHTOOL = ~/repos/GTFO/bin/GTFO.exe

SDIR = src
ODIR = build

PORT = COM3

BMPSRC := $(shell find assets -name "*.bmp")
MIDSRC := $(shell find assets -name "*.mid")
JSONSRC := $(shell find assets -name "*.json")

BMPOBJS = $(patsubst %,$(ODIR)/%,$(BMPSRC:bmp=gtg.deflate))
MIDOBJS = $(patsubst %,$(ODIR)/%,$(MIDSRC:mid=gtm2))
JSONOBJS = $(patsubst %,$(ODIR)/%,$(JSONSRC:json=gsi))

CFLAGS = -t none -Osr --cpu 65c02 --codesize 500 --static-locals
AFLAGS = --cpu 65C02 --bin-include-dir lib --bin-include-dir $(ODIR)/assets
LFLAGS = -C gametank-2M.cfg -m $(ODIR)/out.map -vm
LLIBS = lib/gametank.lib

C_SRCS := $(shell find src -name "*.c")
COBJS = $(patsubst src/%,$(ODIR)/%,$(C_SRCS:c=o))

A_SRCS := $(shell find src -name "*.s")
AOBJS = $(patsubst src/%,$(ODIR)/%,$(A_SRCS:s=o))

_AUDIO_FW = audio_fw.bin.deflate
AUDIO_FW = $(patsubst %,$(ODIR)/assets/%,$(_AUDIO_FW))

include bankMakeList #sets _BANKS
BANKS = $(patsubst %,bin/$(TARGET).%,$(_BANKS))

$(info banks is $(BANKS))

bin/$(TARGET): $(BANKS)
	cat $(BANKS) > $@

 $(BANKS): $(AOBJS) $(COBJS) $(LLIBS) gametank-2M.cfg
	mkdir -p $(@D)
	$(LN) $(LFLAGS) $(AOBJS) $(COBJS) -o bin/$(TARGET) $(LLIBS)

$(ODIR)/assets.o: src/assets.s $(BMPOBJS) $(JSONOBJS) $(AUDIO_FW) $(MIDOBJS)
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

.PHONY: clean whatever

clean:
	rm -rf $(ODIR)/*

flash: $(BANKS)
	$(FLASHTOOL) bin/$(TARGET).bank*

emulate:
	../GameTankEmulator/bin/$(OS)/GameTankEmulator bin/$(TARGET)

whatever:
	echo lol
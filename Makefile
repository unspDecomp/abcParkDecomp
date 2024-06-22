##################################################
# Alphabet Park Adventure Decompilation Makefile #
##################################################

PROGRAM_NAME = AlphabetParkAdventure

IDEDIR       = C://Program Files (x86)/GeneralPlus/unSPIDE_4.0.7

BUILDSRCDIR  = buildSrc
BUILDINFODIR = buildInfo
OUTDIR       =
SRCDIR       = src

CC = wine "$(IDEDIR)/toolchain/gcc.exe"
AS = wine "$(IDEDIR)/toolchain/xasm16.exe"
LD = wine "$(IDEDIR)/toolchain/xlink16.exe"
AR = wine "$(IDEDIR)/toolchain/xlib16.exe"

INCLUDES = -I"$(SRCDIR)" -I"$(IDEDIR)/library/include" -I"$(IDEDIR)/library/include/sys"

BODY	= -body SPG200CBoot -nobdy -bfile "$(BUILDINFODIR)/vsmile.bdy"

LIKFILE = "$(BUILDINFODIR)/$(PROGRAM_NAME).lik"
S37FILE	= "$(PROGRAM_NAME).s37"
ARYFILE	= "$(PROGRAM_NAME).ary"
SBMFILE	= "$(PROGRAM_NAME).sbm"
MAPFILE = "$(PROGRAM_NAME).map"
SMYFILE = "$(PROGRAM_NAME).smy"
SYMFILE = "$(PROGRAM_NAME).sym"
BINFILE = "$(PROGRAM_NAME).tsk"

OPT         = -S -Wall -mglobal-var-iram -mISA=1.1
ASFLAGS     = -t2 -sr -wpop
CASFLAGS	  = -t2 -sr -wpop
CFLAGS	    = $(OPT) -B"$(IDEDIR)/toolchain/" $(INCLUDES)
BINTYPE	    = -as
LDFLAGS	    =
EXTRAFLAGS	=

OBJFILES = \
	$(BUILDSRCDIR)/main.obj \
	$(BUILDSRCDIR)/isr.obj

# ASSEMBLY #
$(BUILDSRCDIR)/main.obj: $(BUILDSRCDIR)/main.c.asm
	cd "$(IDEDIR)/toolchain/" & \
	$(AS) $(CASFLAGS) $(INCLUDES) -o $(BUILDSRCDIR)/main.obj $(BUILDSRCDIR)/main.c.asm

$(BUILDSRCDIR)/isr.obj: $(BUILDSRCDIR)/isr.c.asm
	cd "$(IDEDIR)/toolchain/" & \
	$(AS) $(CASFLAGS) $(INCLUDES) -o $(BUILDSRCDIR)/isr.obj $(BUILDSRCDIR)/isr.c.asm


# C SOURCE COMPILATION #
$(BUILDSRCDIR)/main.c.asm: $(SRCDIR)/main.c
	cd "$(IDEDIR)/toolchain/" & \
	$(CC) $(CFLAGS) $(INCLUDES) -o $(BUILDSRCDIR)/main.c.asm $(SRCDIR)/main.c

$(BUILDSRCDIR)/isr.c.asm: $(SRCDIR)/isr.c
	cd "$(IDEDIR)/toolchain/" & \
	$(CC) $(CFLAGS) $(INCLUDES) -o $(BUILDSRCDIR)/isr.c.asm $(SRCDIR)/isr.c


.SUFFIXES: .c .asm .obj .s37 .tsk .res

all: BEFOREBUILD $(BINFILE) $(BINFILE)

BEFOREBUILD:

$(BINFILE): $(OBJFILES)
	cd "$(IDEDIR)/toolchain/" & \
	$(LD) $(LIKFILE) $(LDFLAGS) $(BODY) $(EXTRAFLAGS)

compile: $(OBJFILES)

clean:
	$(RM) $(BUILDSRCDIR)/main.obj
	$(RM) $(BUILDSRCDIR)/main.c.asm
	$(RM) $(BUILDSRCDIR)/isr.obj
	$(RM) $(BUILDSRCDIR)/isr.c.asm
	$(RM) $(MAPFILE) $(SBMFILE) $(SMYFILE) $(SYMFILE) $(BINFILE)

.c.asm:
	@$(CC) $(CFLAGS) $(INCLUDES) -o $(BUILDSRCDIR)/$@ $<

.asm.obj:
	@$(AS) $(ASFLAGS) $(INCLUDES) -o $(BUILDSRCDIR)/$@ $<

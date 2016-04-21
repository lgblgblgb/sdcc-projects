# (C)2016 Gabor Lenart (LGB)

LIB	= ep128.lib
OLIB	= SDCC-Z80.LIB
SRCS_S	= $(shell ls *.s | fgrep -v crt0.s)
SRCS_C	= $(shell ls *.c)
OBJS	= $(SRCS_S:.s=.rel) $(SRCS_C:.c=.rel)
CRT0	= crt0.rel
AS	= sdasz80
AR	= sdar
CC	= sdcc
ASFLGS	= -plosgffw
ARFLGS	= -rc
CCFLGS	= -mz80 -I. --std-c99 --no-std-crt0
DEPS	= Makefile

all:	
	$(MAKE) dep
	$(MAKE) $(CRT0) $(LIB)

%.rel: %.s $(DEPS)
	$(AS) $(ASFLGS) $@ $<

%.rel: %.c $(DEPS)
	$(CC) $(CCFLGS) -c $< -o $@

$(LIB): $(OBJS) $(DEPS) $(OLIB)
	cp $(OLIB) $(LIB)
	$(AR) $(ARFLGS) $(LIB) $(OBJS)
	@ls -l $(OLIB) $(LIB)

clean:
	rm -f $(LIB) $(OBJS) $(CRT0) *.asm *.lst *.sym official_lib/* .depend

old:
	mkdir -p official_lib
	cd official_lib ; $(AR) x ../$(OLIB)

dep:
	$(MAKE) .depend

.depend: $(DEPS)
	$(CC) -M $(CCFLGS) $(SRCS_C) > .depend

.PHONY: all clean old dep

ifneq ($(wildcard .depend),)
include .depend
endif

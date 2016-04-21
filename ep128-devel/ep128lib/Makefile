LIB	= ep128.lib
OLIB	= /usr/share/sdcc/lib/z80/z80.lib
#SRCS	= abs.s crtcall.s divmixed.s divsigned.s divunsigned.s exos_screen.s fstubs.s heap.s memmove.s modmixed.s modsigned.s modunsigned.s mulchar.s mul.s putchar.s setjmp.s strcpy.s strlen.s stubs.s
SRCS	= putchar.s exos_screen.s
OBJS	= $(SRCS:.s=.rel)
CRT0	= crt0.rel
AS	= sdasz80
AR	= sdar
ASFLGS	= -plosgffw
ARFLGS	= -rc

all:	$(CRT0) $(LIB)

%.rel: %.s
	$(AS) $(ASFLGS) $@ $<

$(LIB): $(OBJS)
	cp $(OLIB) $(LIB)
	ls -l $(LIB)
	$(AR) $(ARFLGS) $(LIB) $(OBJS)
	ls -l $(LIB)

clean:
	rm -f $(LIB) $(OBJS) $(CRT0) *.lst *.sym official_lib/*

old:
	mkdir -p official_lib
	cd official_lib ; $(AR) x $(OLIB)


.PHONY: all clean old


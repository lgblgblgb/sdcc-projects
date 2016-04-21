# SDCC (Small Device C Compiler) related works

SDCC is kinda nice C compiler for "Small Devices" for example PIC MCUs, and
some CPUs as well, for example the Z80. I'm interested in the Z80 part,
though :)

SDCC web page: http://sdcc.sourceforge.net/

## ep128-devel

This is some work about producing a library and crt0 for the Enterprise-128,
also with some wrappers to make development in C using sdcc easier. SDCC's
generic Z80 library is mainly unaffected, and only specific routines are
replaced in the library.


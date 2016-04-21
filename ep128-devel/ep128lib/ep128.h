#ifndef __SDCC_EP128_H_INCLUDED__
#define __SDCC_EP128_H_INCLUDED__

#define EI __asm EI __endasm
#define DI __asm DI __endasm
#define HALT __asm HALT __endasm
#define NOP __asm NOP __endasm

typedef unsigned char ubyte;
typedef signed char sbyte;
typedef unsigned int uword;
typedef signed int sword;

extern void exos_stdio ( void );




#endif


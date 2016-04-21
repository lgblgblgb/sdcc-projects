;--------------------------------------------------------------------------
;  crt0.s - Generic crt0.s for a Z80
;
;  Copyright (C) 2000, Michael Hope
;
;  This library is free software; you can redistribute it and/or modify it
;  under the terms of the GNU General Public License as published by the
;  Free Software Foundation; either version 2, or (at your option) any
;  later version.
;
;  This library is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License 
;  along with this library; see the file COPYING. If not, write to the
;  Free Software Foundation, 51 Franklin Street, Fifth Floor, Boston,
;   MA 02110-1301, USA.
;
;  As a special exception, if you link this library with other files,
;  some of which are compiled with SDCC, to produce an executable,
;  this library does not by itself cause the resulting executable to
;  be covered by the GNU General Public License. This exception does
;  not however invalidate any other reasons why the executable file
;   might be covered by the GNU General Public License.
;--------------------------------------------------------------------------

	.module crt0
	.globl	_main

	.area	_HEADER (ABS)
	.org	0xf0
	;.area	_CODE (ABS)

	;; Enterprise-128 Type-5 file header

	;.org	0x0	; that is really does not matter, as this is the header only ...
;	.dw	0x0500	; 0 and 5 bytes
;	.dw	__END_OF_PRG - 0x100	; length of the defined area stuff
;	.dw	0, 0, 0, 0, 0, 0
	
	;.org	0x100
;init:
;	;; Set stack pointer to this unsane/unsafe position :) Heavy stack usage will create problems. TODO: fix this later!
;	ld	sp, #0x100
;
;       ;; Initialise global variables
;        call    gsinit
;	call	_main
;	jp	_exit
;
;	.db	0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA,0x77,0xAA

	;; Ordering of segments for the linker.
	.area	_HOME
	.area	_CODE
	.area	_INITIALIZER
	.area   _GSINIT
	.area   _GSFINAL

	.area	_DATA
	.area	_INITIALIZED
	.area	_BSEG
	.area   _BSS
	.area   _HEAP
	.area	_SYSTOP

	.area   _CODE
	; LGB - I have no idea, but it seems this generates only something to output, HEADER won't!

	.dw	0x0500, __END_OF_PRG - 0x100, 0, 0, 0, 0, 0, 0

__lgb_test:
	;.dw	__lgb_test
	;.ascii	"LGB"
init:
	LD	SP, #0x100		; TODO	this is really bad, and too small stack area!
	call	gsinit
	call	_main
	jp	_exit


__clock::
	ret

_exit::
	halt
	jr	_exit

	.area   _GSINIT
gsinit::
	ld	bc, #l__INITIALIZER
	ld	a, b
	or	a, c
	jr	Z, gsinit_next
	ld	de, #s__INITIALIZED
	ld	hl, #s__INITIALIZER
	ldir
gsinit_next:

	.area	_SYSTOP
_SYSTOP::

	.area   _GSFINAL
	ret

__END_OF_PRG:


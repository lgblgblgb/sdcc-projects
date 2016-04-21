;--------------------------------------------------------------------------
;  putchar.s
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

        .area   _CODE

__exos_fn_keyboard:
	.db	9
	.ascii	"KEYBOARD:"
__exos_fn_video:
	.db	6
	.ascii	"VIDEO:"


; B = value, C = variable number
__set_exos_var__:
	LD	D, B
	LD	B, #1
	RST	0x30
	.DB	16
	RET


_exos_stdio::
	; Open keyboard channel
	LD	DE, #__exos_fn_keyboard
	LD	A, #2		; keyboard channel
	RST	0x30
	.DB	1
	; Prepare video parameters we need
	LD	BC, # 2 * 256 + 22	; video mode (we use character mode as the starting point!)
	CALL	__set_exos_var__
	LD	BC, # 0 * 256 + 23	; colour mode
	CALL	__set_exos_var__
	LD	BC, #42 * 256 + 24	; screen width
	CALL	__set_exos_var__
	LD	BC, #25 * 256 + 25	; screen height
	CALL	__set_exos_var__
	LD	BC, # 0 * 256 + 26	; show status
	CALL	__set_exos_var__
	LD	BC, # 0 * 256 + 27	; border colour
	CALL	__set_exos_var__
	LD	BC, # 0 * 256 + 28	; fix-BIAS
	CALL	__set_exos_var__
	; Open video channel
	LD	DE, #__exos_fn_video
	LD	A, #1			; video channel
	RST	0x30
	.DB	1
	; Font reset
	LD	A, #1
	LD	B, #4
	RST	0x30
	.DB	11
	; Display video page ...
	LD	A, #1
	LD	BC, #0x101
	LD	DE, #25 * 0x100 + 1	; with screen height in D!
	RST	0x30
	.DB	11
	; Set default channel ...
	LD	BC, #1 * 256 + 4
	CALL	__set_exos_var__
	
	RET


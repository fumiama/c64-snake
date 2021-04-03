.macro print
	pha
	tya
	pha
	lda #<_1	; 取参数的低八位
	ldy #>_1	; 取参数的高八位
	jsr printstr
	pla
	tay
	pla
.macend

; PRINTSTR routine.  Accumulator stores the low byte of the address,
; X register stores the high byte.
.scope
.data zp
.space _ptr 2
.text
printstr:
	sta _ptr
	sty _ptr+1
	ldy #$00
_lp:
	lda (_ptr),y
	beq _done
	jsr chrout
	iny
	bne _lp
_done:
	rts
.scend
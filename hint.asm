printhint:
	clc
	ldx #20			; 光标来到正确位置
	ldy #8
	jsr plot
	`print starthint
	rts
printfail:
	clc
	ldx #20			; 光标来到正确位置
	ldy #8
	jsr plot
	`print failhint
	rts
erasehint:
	ldy #22
	lda #csps
*	sta [title+20*40+8-1], y
	dey
	bne -
	rts

starthint:	.byte "PRESS ANY KEY TO START", 0
failhint:	.byte "FAILED:PRESS TO RETURN", 0
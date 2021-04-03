.outfile "printinput.prg"
.require "platform/c64header.oph"
.require "platform/c64kernal.oph"

main:
*	jsr getin
	beq skip
	cmp #'@
	beq end
	jsr printbyte
	lda #13		; 换行
	jsr chrout
skip:
	jmp -
end:
	rts

.require "printbyte.asm"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; print16 从内存打印16位int(十进制5位),空位补0
; 以BE方式存储以便打印
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print16:
.scope
.data zp
.space _num 6
.text
	pha
	txa
	pha
	
    lda #0
    ldx #6
*   dex
    sta _num, x
    bne -

	`splitbyte s, 4
	`splitbyte s + 1, 2
    `carry
	`print _num

	pla
	tax
	pla
    rts

mod10:
    lda _num, y
    ldx #$ff
    clc
*   inx
    ;jsr printbyte
    sbc #9
    ;jsr printbyte
    ;dey
    ;rts
    bcc -
    clc
    adc #$3a
    sta _num, y
    txa
    dey
    adc _num, y
    sta _num, y
    rts
.scend

.macro splitbyte
	lda _1
	sta _num + _2
    ;jsr printbyte
	lsr
	lsr
	lsr
	lsr
	sta _num + _2 - 1
    ;jsr printbyte
	lda #$0f
	and _num + _2
	sta _num + _2
    ;jsr printbyte
.macend

.macro carry
    tya
    pha

    ldy #4
*   jsr mod10
    ; dey
    bne -
    lda #$30
    clc
    adc _num
    sta _num
    
    pla
    tay
.macend

 .require "printbyte.asm"
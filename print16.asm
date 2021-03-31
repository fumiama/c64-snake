;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; print16 从内存打印16位int(十进制5位),空位补0
; 以BE方式存储以便打印
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro print16
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

	`splitbyte _1, 4
	`splitbyte _1 + 1, 2
    `carry
	`print _num

	pla
	tax
	pla
    rts

mod10:
    lda _num, y
    ldx #$ff
*   inx
    clc
    sbc #10
    bcc -
    clc
    adc #$3a
    sta _num, y
    txa
    dey
    adc _num, y
    sta _num, y
    rts
.macend

.macro splitbyte
	lda _1
    jsr printbyte
	sta _num + _2
	lsr
	lsr
	lsr
	lsr
	sta _num + _2 - 1
	lda #$0f
	ora _num + _2
	sta _num + _2
.macend

.macro carry
    tya
    pha

    ldy #4
*   jsr mod10
    ; dey
    bne -
    
    pla
    tay
.macend

.require "printbyte.asm"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; print16 从内存打印16位int(十进制5位),空位补0
; 以BE方式存储以便打印
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print16:
.scope
.data zp
.space _num 6
.space _num_dec 6
.text
	pha
	txa
	pha
	
    lda #0
    ldx #6
*   dex
    sta _num, x
    sta _num_dec, x
    bne -

	`splitbyte s, 4
	`splitbyte s + 1, 2
    `carry
	`print _num_dec

	pla
	tax
	pla
    rts

_store:
    adc _num_dec, y
    sta _num_dec, y
    ;jsr printbyte
    rts

_store2:
    adc _num_dec, y
    sta _num_dec, y
    ;jsr printbyte
    dey
    lda #1
    sta _num_dec, y
    rts

mod_4: `mod10 4, $26

mod_3: `mod10 3, $2c

mod_2: `mod10 2, $28

mod_1: `mod10 1, $2a
.scend

.macro mod10
    ldy #_1
    lda _num, y
    ;jsr printbyte
    cmp #10
    clc
    bmi _s
    adc #_2
    jsr _store2
    rts
_s: adc #$30
    jsr _store
    rts
.macend

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

    jsr mod_4
    jsr mod_3
    jsr mod_2
    jsr mod_1
    lda #$30
    clc
    adc _num_dec
    sta _num_dec
    
    pla
    tay
.macend

 .require "printbyte.asm"
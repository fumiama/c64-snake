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

mod10:
    lda _num, y
    cmp #10     ; 4位的数只有大于/小于10两种情况
    bmi +       ; 小于等于10
    adc #$25    ; 此时c=0
    sta _num_dec, y
    jsr printbyte
    dey
    lda #1
    adc _num_dec, y
    sta _num_dec, y
    jsr printbyte
    iny
    jmp ++
*   adc #$2f    ; 此时c=1
    adc _num_dec, y
    sta _num_dec, y
*   rts
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
    dey
    bne -
    lda #$30
    clc
    adc _num
    sta _num
    
    pla
    tay
.macend

 .require "printbyte.asm"
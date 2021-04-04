;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; print16 从内存打印16位int(十进制5位),空位补0
; 以BE方式存储以便打印
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print16:
.scope
.data
.space _num 4
.space _num_dec 6
.text
	pha
	txa
	pha
	
	lda #0
	ldx #6
*	sta _num_dec-1, x
	dex
	bne -

	`splitbyte s, 3
	`splitbyte s + 1, 1
	`carry
	`print _num_dec

	pla
	tax
	pla
	rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; mod函数处理的数据为打印方便均使用大端序存储
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mod_4:					; 高字节低4位若大于10，则向高位进1
	lda _num + 3
	cmp #10
	bcc +
	sbc #10				; 此时c为1
	tax
	lda #1
	sta _num_dec + 3	; 进位
	txa
*	sta _num_dec + 4
	rts

mod_3:					; 高字节高4位的值相当于个位加6，十位加1
	ldx _num + 2
	bne +				; 如果为0直接返回
	rts
*	lda #6
	`carry10 4
	lda #1
	`carry10 3
	dex
	bne -
	rts

mod_2:					; 低字节低4位的值相当于个位加6，十位加5，百位加2
	ldx _num + 1
	bne +				; 如果为0直接返回
	rts
*	lda #6
	`carry10 4
	lda #5
	`carry10 3
	lda #2
	`carry10 2
	dex
	bne -
	rts

mod_1:					; 低字节低4位的值相当于个位加6，十位加9，百位加0，千位加4
	ldx _num
	bne +				; 如果为0直接返回
	rts
*	lda #6
	`carry10 4
	lda #9
	`carry10 3
	lda #4
	`carry10 1
	dex
	bne -
	rts

.scend

.macro carry10
	clc
	adc _num_dec + _1
	bcc _skip
	pha
	lda #$10				; 进位相当于100
	clc
	adc _num_dec + _1 - 1
	sta _num_dec + _1 - 1
	pla
_skip:
	sta _num_dec + _1
.macend

.macro splitbyte
	lda _1
	sta _num + _2
	lsr
	lsr
	lsr
	lsr
	sta _num + _2 - 1
	lda #$0f
	and _num + _2
	sta _num + _2
.macend

.macro carry
	tya
	pha

	sed				; 设置为bcd加减法
	jsr mod_4
	jsr mod_3
	jsr mod_2
	jsr mod_1		; 此时结果中有些位可能大于10，需要进行进位处理
	ldx #5
_loop:
	ldy #0			; y记录进位数
	txa
	lda _num_dec-1, x
	cmp #10
	bcc _skip		; 小于10不进位
	pha
	and #$f0
	lsr
	lsr
	lsr
	lsr
	adc _num_dec-2, x
	sta _num_dec-2, x
	pla
	and #$0f
	sta _num_dec-1, x
_skip:
	dex
	bne _loop

	cld				; 退出bcd模式
	ldx #5
_up:
	lda _num_dec - 1, x
	ora #$30		; 转化为可显示字符
	sta _num_dec - 1, x
	dex
	bne _up

	pla
	tay
.macend

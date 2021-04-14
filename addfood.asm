;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; addfood 随机生成食物
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
addfood:
.scope
.data
.space seed 6
.text
	lda #<field
	sta _ptr
	lda #>field
	sta _ptr + 1
	
	`propagate seed, $c3
	`propagate seed+1, $9e
	`propagate seed+2, $26
	`propagate seed, seed+1
	`propagate seed+1, seed+2
	`propagate seed+2, seed+3
	
	lda seed + 5
	ldx seed + 4
	sta seed + 4
	lda seed + 3
	stx seed + 3
	ldx seed + 2
	sta seed + 2
	lda seed + 1
	stx seed + 1
	ldx seed
	sta seed
	stx seed + 5

	lda seed
	tay
	lda seed + 1
	and #$03
	beq +
	clc
	adc _ptr + 1
	sta _ptr + 1
*	cmp #$03
	bne +
	tya
	cmp #$c0
	bmi +
	sbc #$c0
	tay
*	iny
	lda (_ptr), y
	cmp #csps
	bne -
	lda #crnd
	sta (_ptr), y
	rts
.scend

srand:			; 做随机种子的初始化
.scope
	jsr rdtim
	sta seed + 5
	stx seed + 3
	sty seed + 1
	rts
.scend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; propagate 进位
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro propagate
	lda _1
	clc
	adc _2
	bcc _end
	inc _1 + 1
	bne _end
	inc _1 + 2
	bne _end
	inc _1 + 3
	bne _end
	inc _1 + 4
	bne _end
	inc _1 + 5
_end:
	sta _1
.macend
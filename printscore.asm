;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; printscore 打印分数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printscore:
.scope
	clc
	ldx #0			; 光标回到原点
	ldy #0
	jsr plot
	lda #cblk
	ldx #15
*	jsr chrout
	dex
	bne -
	`print score_str
	jsr print16
	ldx #15
*	jsr chrout
	dex
	bne -
	rts
.scend

score_str: .byte "SCORE",0
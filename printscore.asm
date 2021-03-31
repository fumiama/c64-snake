;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; printscore 打印分数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printscore:
.scope
	lda #cblk
	ldx #15
*	jsr chrout
	dex
	bne -
	`print score_str
    `print16 s
	ldx #15
*	jsr chrout
	dex
	bne -
	rts
.scend

score_str: .byte "SCORE",0
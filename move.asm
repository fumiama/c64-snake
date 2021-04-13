;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; move 根据d中的值实现蛇的移动
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
move:
.scope
	;lda #1				;演示用
	;sta eat			
	lda eat				;eat判断，进入两种移动模式
	;bne +++++			;进入模式一：四种移动模式（吃到）（头动，尾不动）
	lda d
	;lda #go_l			;测试用
	cmp #go_d
	bne +
	clc
	lda shead			;new head 
	adc #40
	sta shead
	lda shead+1
	adc #0
	sta shead+1
	ldy #0				;head move down
	lda #csnk
	sta (shead),y    
	rts
*	cmp #go_r
	bne +
	clc
	lda shead			;new head
	adc #1
	sta shead
	lda shead+1
	adc #0
	sta shead+1
	ldy #0				;head move right
	lda #csnk
	sta (shead),y    
	rts
*	cmp #go_l
	bne +
	clc
	lda shead			;new head
	sec
	sbc #1
	sta shead
	lda shead+1
	sbc #0
	sta shead+1
	ldy #0				;head move left
	lda #csnk
	sta (shead),y    
	rts
*	cmp #go_u
	bne +
	clc
	lda shead			;new head
	sec
	sbc #40
	sta shead
	lda shead+1
	sbc #0
	sta shead+1
	ldy #0				;head move up
	lda #csnk
	sta (shead),y    
*	rts
;模式二：四种移动模式
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	lda d
;	lda #go_d		;实验用
;	cmp go_d
;	beq +
;	lda #csps
;	ldy #0
;	sta (shead),y
;	lda #csnk
;	ldy #40
;	sta (shead),y
;	clc
;	lda shead
;	adc #40
;	sta shead
;	lda shead+1
;	adc #0
;	sta shead+1
;*	rts
.scend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; calcscore 计算分数，存储到s
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
calcscore:
.scope
	inc s
	bne +
	inc s+1
*	rts
.scend
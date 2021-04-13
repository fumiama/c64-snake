;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 日期：2021-4-11
; 食物：crnd $51
; 墙：cblk $66
; 像素：csnk
; 蛇头 (shead)
; 键入方向d(8bit)->
; 宽38 高23
;;;;;;;;;;;;;;;;;;;;撞墙伪码;;;;;;;;;;;;;;;;;;;;;;;;;
; （(shead) 与 d(new)运算）的位置的内容 CMP cblk
;  忘了 = ->sec
;  忘了 = ->clc
;;;;;;;;;;;;;;;;;;;撞自己伪码;;;;;;;;;;;;;;;;;;;;;;;;
; （(shead) 与 d(new)运算）的位置的内容 CMP csnk
;  忘了 = ->sev
;  忘了 = ->clc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; judgeout 判断是否出界/撞到自身
; 是->sec 即进位标志置1
; 否->clc 即进位标志置0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;关于指令cmp：
;;相等Z=1；不等Z=0
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
judgeout:
.scope
	lda d
	;;方向向上
	cmp #go_u
	beq _gup
	;;方向向下
	cmp #go_d
	beq _gdown
	;;方向向左
	cmp #go_l
	beq _gleft
	;;方向向右
	cmp #go_r
	beq _gright
	jmp _End1 				;什么都没有撞

;是否撞墙；是否考虑溢出情况；撞墙撞自己要不要分开写？
_gup:	 				;地址-40?实现：/减法/地址跳跃
		lda shead
		sec
		sbc #40 
		sta _ptr
		lda shead+1
		sbc #0
		sta _ptr+1
		ldy #0
		lda (_ptr),y

	 	cmp #cblk
		beq _End2 
	 	jmp _selfx

_gdown: ldy #40	   			;地址+40,好像有问题，这个(shead)是蛇头地址的地址了 拟修改:lda (取低位用啥来着)(shead),sec,  adc #40,  
		lda (shead),y
	    cmp #cblk
	    beq _End2
	    jmp _selfx

_gleft: 
		lda shead
		sec
		sbc #1 
		sta _ptr
		lda shead+1
		sbc #0
		sta _ptr+1
		ldy #0
		lda (_ptr),y

	    cmp #cblk
	    beq _End2
	    jmp _selfx

_gright:ldy #1				;地址+1，好像有问题，这个(shead) 拟修改:lda (取低位用啥来着)(shead),sec,adc # 
		lda (shead),y
		cmp #cblk
		beq _End2

_selfx: cmp #csnk
		beq _End2

;蛇没死
_End1:  clc
		rts
;蛇死了
_End2:  sec
		rts

.scend
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; judgefood 判断是否吃到食物
; 是->sec 即进位标志置1
; 否->clc 即进位标志置0
;;;;;;;;;;;;;;;;;;;;;;;食物伪码;;;;;;;;;;;;;;;;;;;;;;;
; （(shead) 与 d(new)运算）的位置的内容 CMP crnd
;  忘了 = ->sec
;  忘了 = ->clc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

judgefood:
.scope
	lda d
	;;方向向上
	cmp #go_u
	beq _gup
	;;方向向下
	cmp #go_d
	beq _gdown
	;;方向向左
	cmp #go_l
	beq _gleft
	;;方向向右
	cmp #go_r
	beq _gright
	jmp _End1 				;输入了一个无效字符，，，，，？

;是否撞墙；是否考虑溢出情况-不用；撞墙撞自己要不要分开写？
_gup:	
	    lda shead
		sec 
	    sbc #40
		sta _ptr
		lda shead+1
		sbc #0
		sta _ptr+1
		ldy #0
		lda (_ptr),y

		cmp #crnd
	    beq _End2
	    bne _End1

_gdown: ldy #40	   			;地址+40
	    lda (shead),y
	    cmp #crnd
	    beq _End2
	    bne _End1

_gleft: 

	    lda shead
		sec 
	    sbc #1
		sta _ptr
		lda shead+1
		sbc #0
		sta _ptr+1
		ldy #0
		lda (_ptr),y

		cmp #crnd
	    beq _End2
	    bne _End1

_gright:ldy #1				;地址+1
		lda (shead),y
		cmp #crnd
		beq _End2

;没吃到
_End1:  clc
		rts
;吃到了
_End2:  sec
		rts


.scend
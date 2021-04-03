.outfile "snake.prg"
.require "platform/c64_0.oph"
.require "platform/c64kernal.oph"

.alias cblk $a6

.alias go_u $55	 ; 上
.alias go_d $5f	 ; 下
.alias go_l $1d	 ; 左
.alias go_r $32	 ; 右
.alias st_g $a0	 ; 开始/暂停
.alias ed_g $20	 ; 结束

.data zp
.space d 1		; 方向 值定义如上
.space c 1		; 🐍长度 最大255 最小0
.space s 2		; 得分 小端序
.text

main:
.scope
	`init
	
	rts
.scend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; init 初始化界面、变量
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro init
	lda #147	 ;清屏
	jsr chrout
	lda #$cd
	sta s
	lda #$ab
	sta s + 1
	jsr printscore
.macend

.require "printscore.asm"
.require "print16.asm"
.require "print.asm"

.checkpc $A000	; text段边界
.data zp		  ; 零页段边界
.checkpc $80
.data
.checkpc $D000	; data段边界
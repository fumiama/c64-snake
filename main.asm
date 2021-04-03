.outfile "snake.prg"
.require "platform/c64_0.oph"
.require "platform/c64kernal.oph"
.require "head.asm"

main:
.scope
	`init
	
	rts
.scend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; init 初始化界面、变量
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro init
	lda #147		; 清屏
	jsr chrout
	lda #$00
	sta s
	lda #$00
	sta s + 1		; 初始化分数为0
	jsr printscore	; 打印分数
	lda #1
	sta field + 11*38 + 19	; 初始化蛇位置
	sta c			; 初始化蛇长为1
	jsr printfield	; 打印蛇，包括边框
.macend

.require "printscore.asm"
.require "print16.asm"
.require "printfield.asm"
.require "print.asm"

.checkpc $A000	; text段边界
.data zp		; 零页段边界
.checkpc $80
.data
.checkpc $D000	; data段边界
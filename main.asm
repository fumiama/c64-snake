.outfile "snake.prg"
.require "platform/c64_0.oph"
.require "platform/c64kernal.oph"
.require "head.asm"

main:
.scope
	`init
	jsr getchar		; 等待输入任意字符开始游戏
	jsr erasehint	; 游戏开始，清空提示
*	clc
	jsr judgeout	; 判断是否出界
	bcc +
	jsr printfail
	jsr getchar
	rts
*	clc
	lda #0
	sta eat
	jsr judgefood	; 判断是否吃到食物
	bcc +
	lda #1
	sta eat
	jsr addfood
*	jsr move		; 蛇移动一格
	jsr calcscore	; 计算得分
	jsr printscore	; 打印分数
	lda d
	sta prev_d		; 备份前一个按键
	lda #20
	jsr delay		; 延时期间最后一个按键位于d
	lda d
	cmp #ed_g
	beq _end
	cmp #st_g
	bne ---
	jsr getchar
	lda prev_d
	sta d			; 恢复按键
	jmp ---
_end:
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
	sta eat
	sta s + 1		; 初始化分数为0
	jsr printscore	; 打印分数
	jsr move_init
	jsr printfield	; 打印蛇，包括边框
	jsr printhint	; 打印开始提示
	lda #go_d		; 初始化方向为下
	sta d
	jsr srand		; 初始化随机数种子
	jsr addfood		; 增加食物
.macend

.require "printscore.asm"
.require "print16.asm"
.require "printfield.asm"
.require "hint.asm"
.require "getchar.asm"
.require "addfood.asm"
.require "delay.asm"
.require "judge.asm"
.require "move.asm"
.require "calcscore.asm"
.require "print.asm"

.checkpc $a000	; text段边界
.data zp		; 零页段边界
.checkpc $80
.data
.checkpc $d000	; data段边界
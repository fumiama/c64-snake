.outfile "snake.prg"
.require "platform/c64_0.oph"
.require "platform/c64kernal.oph"

.alias go_u #1  ; 上
.alias go_d #2  ; 下
.alias go_l #4  ; 左
.alias go_r #8  ; 右

.data zp
.space d 1 ; 方向 值定义如上
.space c 1 ; 长度 最大255 最小0
.text

main:
.scope
    lda #147    ;清屏
    jsr chrout
    
    rts
.scend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; getdir 返回一个方向到d
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getdir:
.macro
    jsr chrin
    sta d
.macend


.checkpc $A000	; text段边界
.data zp        ; 零页段边界
.checkpc $80
.data
.checkpc $D000	; data段边界
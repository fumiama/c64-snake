;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; printfield 打印蛇，包括边框
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
printfield:
.scope
.data zp
.space _ptr 2
.text
    ldx #23     ; i代表行数，不含边框
    lda #<field ; 取地址低8位
    sta _ptr
    lda #>field ; 取地址高8位
    sta _ptr + 1
    ldy #0
*   lda #cblk
    sta (_ptr), y   ; 打印左边框
    lda #39
    jsr _addptr
    lda #cblk
    sta (_ptr), y   ; 打印右边框
    lda #1
    jsr _addptr
    dex
    bne -
    lda #cblk
    ldy #40
    dec _ptr
*   sta (_ptr), y    ; 打印底边
    dey
    bne -
    ldx #0
    jsr plot
    rts

_addptr:
    clc
    adc _ptr
    bcc +
    inc _ptr + 1
*   sta _ptr
    rts
.scend

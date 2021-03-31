.outfile "printinput.prg"
.require "platform/c64header.oph"
.require "platform/c64kernal.oph"

.data
.org $C000
.space _na 1	; a的临时存放处

.text
main:
*   jsr getin
    beq skip
    cmp #'@
    beq end
    jsr printbyte
    lda #13		; 换行
    jsr chrout
skip:
    jmp -
end:
    rts

printbyte:
    sta _na
    txa
    pha
    ldx #8	    ; 打印8bit
*   lda #$30	; a = '0'
    asl _na		; 左移一位，溢出到c
    adc #0		; a = a + c + 0
    jsr chrout	; putchar(a)
    dex			; x--
    bne -		; if(x != 0) goto 上个星号
    pla
    tax
    rts
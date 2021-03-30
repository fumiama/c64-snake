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
    jsr printbyte
    lda #13		; 换行
    jsr chrout
skip:
    jmp -

printbyte:
    sta _na
    txa
    pha
    ldx #7	; 打印8bit
*   lda #$30	; a = '0'
    asl _na		; 左移一位，溢出到c
    bcc +		; if(c == 0) goto 下一个星号
    adc #0		; else a = a + c + 0
*   jsr chrout	; putchar(a)
    dex			; x--
    bne --		; if(x != 0) goto 上两个星号
    pla
    tax
    rts
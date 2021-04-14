;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; move 根据d中的值实现蛇的移动
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.scope
.data zp
.space _stail 2      ; 蛇尾指针
.space _tmp 1
.text
move:
	;lda #0				;演示用
	;sta eat			
	lda eat				;eat判断
	bne _head_move			;吃到食物直接进入模式一：head move，否则先执行tail move
	lda #csps
	ldy #0
	sta (_stail),y			;tail move
	ldy #40
	lda (_stail),y
	cmp #csnk			;down search
	bne +
	lda #40
	jsr _propergate_tail
	jsr _head_move
	rts
*	ldy #1
	lda (_stail),y
	cmp #csnk			;right search
	bne +
	lda #1
	jsr _propergate_tail
	jsr _head_move
	rts
*	jsr _copy_to_ptr
	lda #40
	sta _tmp
	jsr _borrow_ptr
	ldy #0
	lda (_ptr),y
	cmp #csnk			;up search
	bne +
	jsr _copy_to_tail
	jsr _head_move
	rts
*	jsr _copy_to_ptr
	lda #1
	sta _tmp
	jsr _borrow_ptr
	lda (_ptr),y
	cmp #csnk			;left search
	bne _head_move
	jsr _copy_to_tail
	jsr _head_move
	rts
;;;;;;;;;;;;;;;;;;;;;;;;;
; head move
;;;;;;;;;;;;;;;;;;;;;;;;;
_head_move:
	;lda #go_l			;测试用
	ldy #0
	`_m_judge_dir_head go_d, 40, _propergate_head
	`_m_judge_dir_head go_r,  1, _propergate_head
	`_m_judge_dir_head go_l,  1, _borrow_head
	`_m_judge_dir_head go_u, 40, _borrow_head
	rts

move_init:
	lda #csnk
	sta field + 10*40 + 19	; 初始化蛇位置
	sta field + 11*40 + 19	; 初始化蛇位置
	lda #<[field + 11*40 + 19]	;初始化蛇头
	ldx #>[field + 11*40 + 19]
	sta shead
	stx shead+1
	lda #<[field + 10*40 + 19]	;初始化蛇尾
	ldx #>[field + 10*40 + 19]
	sta _stail
	stx _stail+1
	rts

_propergate_tail:
	`_m_propergate _stail

_propergate_head:
	`_m_propergate shead

;;;;;;;;;;;;;;;;;;;;;;;;
; 减法借位，入参为_tmp
;;;;;;;;;;;;;;;;;;;;;;;;
_borrow_ptr:
	`_m_borrow _ptr

_borrow_head:
	`_m_borrow shead

_copy_to_ptr:
	lda _stail
	sta _ptr
	lda _stail+1
	sta _ptr+1
	rts

_copy_to_tail:
	lda _ptr
	sta _stail
	lda _ptr+1
	sta _stail+1
	rts
.scend

;;;;;;;;;;;;;;;;;;;;;;;;
; 加法进位，入参为a
;;;;;;;;;;;;;;;;;;;;;;;;
.macro _m_propergate
	clc
	adc _1
	sta _1
	bcc _end
	inc _1+1
_end:
	rts
.macend

;;;;;;;;;;;;;;;;;;;;;;;;
; _tmp:减数 _1:被减数
;;;;;;;;;;;;;;;;;;;;;;;;
.macro _m_borrow
	lda _1
	sec
	sbc _tmp
	sta _1
	bcs _end
	dec _1+1
_end:
	rts
.macend

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; _1:方向 _2:进位/借位数 _3:进位/借位函数
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro _m_judge_dir_head
	lda d
	cmp #_1
	bne _next
	lda #_2
	sta _tmp
	jsr _3
	lda #csnk
	sta (shead),y
	rts
_next:
.macend
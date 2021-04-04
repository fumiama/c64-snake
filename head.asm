.alias cblk $66		; 边框
.alias csnk $a0		; 像素
.alias csps $20		; 空白

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 按钮配置，调试时使用WASD控制
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.alias go_u 'W  ;$55		; 上
.alias go_d 'S  ;$5f		; 下
.alias go_l 'A  ;$1d		; 左
.alias go_r 'D  ;$32		; 右
.alias st_g 'P  ;$a0		; 开始/暂停
.alias ed_g 'Q  ;$20		; 结束

.data zp
.space d 1			; 方向 值定义如上
.space c 1			; 🐍长度 最大255 最小0
.space s 2			; 得分 小端序
.space _ptr 2       ; 通用指针

.alias title $0400
.alias field $0428  ; 蛇所在屏幕内存区

.data
.org $c000	
.text
.alias cblk $66		; 边框
.alias csnk $a0		; 像素
.alias csps $20		; 空白

.alias go_u $55	 	; 上
.alias go_d $5f	 	; 下
.alias go_l $1d	 	; 左
.alias go_r $32	 	; 右
.alias st_g $a0	 	; 开始/暂停
.alias ed_g $20	 	; 结束

.data zp
.space d 1			; 方向 值定义如上
.space c 1			; 🐍长度 最大255 最小0
.space s 2			; 得分 小端序

.data
.org $0400
.space title 40
.space field 960	; 蛇所在屏幕内存区

.text
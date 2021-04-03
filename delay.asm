; DELAY routine.  Takes values from the Accumulator and pauses
; for that many jiffies (1/60th of a second).
.scope
.data zp
.space _tmp 1
.space _target 1
.text

delay:  sta _tmp		; save argument (rdtim destroys it)
		jsr rdtim
		clc
		adc _tmp		; add current time to get target
		sta _target
*       jsr rdtim
		cmp _target
		php
		jsr getin
		beq +
		sta d
*		plp
		bmi --			; Buzz until target reached
		rts
.scend

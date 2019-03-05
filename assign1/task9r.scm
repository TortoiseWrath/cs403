(define (ramanujanr n)
	(define (rama x) 
		(cond
			((== (+ n 2) x) 0)
			(else 
				(* x
					(sqrt (+ 5 x (rama (+ x 1))))
				)
			)
		)
	)
	(rama 1)
)

(define (main)
	;(setPort (open (getElement ScamArgs 1) 'read))
    ;(define n (readInt))
	(define n (int (getElement ScamArgs 1)))
	(println "(ramanujanr " n ") is " (fmt "%.25f" (real (ramanujanr n))))
	(println "$4$")
)
(define (ramanujani n)
	(define (rama-iter store x) 
		(if (== x 1)
			store
			(rama-iter
				(sqrt (+ 4 x (* x store)))
				(- x 1)
			)
		)
	)
	(rama-iter 0 (+ n 2))
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define n (readInt))
	(println "(ramanujani " n ") is " (fmt "%.25f" (real (ramanujani n))))
	(println "$4$")
)
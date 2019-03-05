(define (efci n)
	(define (efci-iter store n)
		(if (== 0 n)
			store
			(efci-iter 
				(/ 1.0
					(+ 1 (/ 1.0
						(+ n (/ 1.0
							(+ 1 store)
						))
					))
				)
				(- n 2)
			)
		)
	)
	(real (+ 2 (efci-iter 0 (* n 2))))
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define n (readInt))
	(println "(efci " n ") is " (fmt "%.25f" (efci n)))
)
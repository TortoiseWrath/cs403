(define (ecfr n)
	(define (r i)
		(if (== n 0)
		0
			(/ 1.0
				(+ 1 (/ 1.0
					(+ (* 2 i) (/ 1.0
						(+ 1 
							(if (== i n)
								0
								(r (+ 1 i))
							)
						)
					))
				))
			)
		)
	)
	(+ 2.0 (r 1))
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define n (readInt))
	(println "(ecfr " n ") is " (fmt "%.25f" (ecfr n)))
)
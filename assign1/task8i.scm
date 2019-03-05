(define (ecfi n)
	(define (ecfi-iter store state n)
		(if (== 0 n)
			(+ 2.0 store)
			(ecfi-iter
				(/
					1.0
					(+
						(if (== state 2)
							n
							1
						)
						store
					)				
				)
				(if (== state 1)
					3
					(- state 1)
				)
				(if (== state 1)
					(- n 2)
					n
				)
			)
		)
	)
	(ecfi-iter 0.0 3 (* n 2))
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define n (readInt))
	(println "(ecfi " n ") is " (fmt "%.25f" (ecfi n)))
)
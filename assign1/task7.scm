(define (double x) 
	(+ x x)
)

(define (halve x)
	(define (maxPower subx start) 
		(if (> (double (double start)) subx)
			start
			(maxPower subx (double start))
		)
	)

	(define (partialHalve subx power)
		(define mp (maxPower subx 1))
		(if (<= subx 1) 
			0
			(+ mp (partialHalve (- subx (double mp)) 1))
		)
	)
	
	(partialHalve x 1)
)

(define (div2? x)
	(== x (double (halve x)))
)

(define (ethiop a b)
	(+
		(if (div2? b)
			0
			a
		)
		(if (== b 1)
			0
			(ethiop (double a) (halve b))
		)
	)
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define a (readExpr))
	(define b (readExpr))
	(println "(halve " a ") is " (halve a))
	(println "(double " a ") is " (double a))
	(println "(div2? " a ") is " (div2? a))
	(println "(ethiop " a " " b ") is " (ethiop a b))
)
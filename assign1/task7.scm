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

	(define (partialHalve sum subx power)
		(define mp (maxPower subx 1))
		(if (<= subx 1) 
			sum
			(partialHalve (+ mp sum) (- subx (double mp)) 1)
		)
	)
	
	(partialHalve 0 x 1)
)

(define (div2? x)
	(== x (double (halve x)))
)

(define (ethiop a b)
	(define (ethiop-iter sum a b)
		(cond
			((div2? b) (ethiop-iter sum (double a) (halve b)))
			((== b 1) (+ sum a))
			(else (ethiop-iter (+ sum a) (double a) (halve b)))
		)
	)
	(ethiop-iter 0 a b)
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
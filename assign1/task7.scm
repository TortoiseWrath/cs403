(define (double x) 
	(+ x x)
)

(define (halve x)
	(define (maxPower subx start) 
		(if (> (+ start start start start) subx)
			start
			(maxPower subx (+ start start))
		)
	)

	(define (halve-iter sum subx power)
		(define mp (maxPower subx 1))
		(if (<= subx 1) 
			sum
			(halve-iter (+ mp sum) (- subx (+ mp mp)) 1)
		)
	)
	
	(halve-iter 0 x 1)
)

(define (div2? x)
	(define (maxPower subx start) 
		(if (> (+ start start start start) subx)
			start
			(maxPower subx (+ start start))
		)
	)

	(define (div2-iter subx power)
		(define mp (maxPower subx 1))
		(if (<= subx 1) 
			(if (== subx 1)
				#f
				#t
			)
			(div2-iter (- subx (+ mp mp)) 1)
		)
	)
	
	(div2-iter x 1)
)

(define (ethiop a b)
	(define (ethiop-iter sum a b)
		(cond
			((div2? b) (ethiop-iter sum (+ a a) (halve b)))
			((== b 1) (+ sum a))
			(else (ethiop-iter (+ sum a) (+ a a) (halve b)))
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
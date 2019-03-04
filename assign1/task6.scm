
(define (S f n) 
	(if (== n 0) 
		(f 0)
		(+ (f n) (S f (- n 1)))
	)
)

(define (w f i)
	(cond 
		((== i 0) (f i))
		(else 
			(define a (S f (- i 1)))
			(define b (+ a (f i)))
			(define c (+ b (f (+ i 1))))
			(/
				(real (- (* c a) (^ b 2)))
				(+ (- c (* 2 b)) a)
			)
		)
	)
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
	(define f (eval (readExpr) this))
	(define n (readInt))
	(println "(S " f " " n ") is " (fmt "%.15f" (real (S f n))))
	(println "(w " f " " n ") is " (fmt "%.15f" (real (w f n))))
)
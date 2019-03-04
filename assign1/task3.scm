(define (root-n n)
	(lambda (x)
		(define (closeEnough y delta) 
			(< (abs (/ delta y)) 1.0e-10)
		)

		(define (betterGuess y)
			(/ (+ (* y (- n 1)) (/ x (^ y (- n 1)))) n)
		)

		(define (rootIter y delta)
			;(println "guess is " (fmt "%.20f" y))
			(if (closeEnough y delta)
				y
				(rootIter (betterGuess y) (- (betterGuess y) y))
			)
		)
		
		(rootIter (betterGuess 1.0) (- (betterGuess 1.0) 1.0))
	)
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define n (readExpr))
	(define x (readExpr))
	(println "((root-n " n ") " x ") is " (fmt "%.15f" ((root-n n) x)))
)
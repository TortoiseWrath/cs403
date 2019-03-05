(define (efci n)
	(real 7)
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define n (readInt))
	(println "(efci " n ") is " (fmt "%.25f" (efci n)))
)
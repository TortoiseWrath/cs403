(define (range start end step)
	(define (rangeIter store start end step)
		(if (< end start)
			store
			(rangeIter (cons end store) start (- end step) step)
		)
	)
	(rangeIter (list) start (- end step) step)
)

(define (for-loop l p)
	(if (null? l)
		1 ;return this
		(begin
			(p (car l))
			(for-loop (cdr l) p)
		)
	)
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
	(define env this)
    (define (iter expr)
         (if (not (eof?)) (begin (eval expr env) (iter (readExpr))))
         )
    (iter (readExpr))
)
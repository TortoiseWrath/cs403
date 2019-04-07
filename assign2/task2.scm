(define (curry f @)
	(if (> (length @) 0)
		(if (list? (car @))
			(define @ (car @))
		)
	)
	(if (== (length @) (length (get 'parameters f))) 
		(apply f @)
		(begin
			(define curried @)
			(lambda (@)
				; (inspect curried)
				; (inspect @)
				(if (nil? curried)
					(curry f @)
					(curry f (append curried @))
				)
			)
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
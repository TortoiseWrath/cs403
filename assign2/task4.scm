

(define (let*->lambdas source)
	(define (lambdify f vars)
		(if (nil? vars)
			f
			(lambdify
				(list (list ; f is: ((lambda (firstvar) oldf) firstval)
					(append
						(list
							'lambda
							(list (car (car vars))) ;(firstvar)
						)
						f ;oldf
					)
					(car (cdr (car vars))) ;firstval
				))
				(cdr vars)
			)
		)
	)
	(if (== 'let* (car (car (cdr (cdr source)))))
		(list 'define (car (cdr source)) (car (lambdify (cdr (cdr (car (cdr (cdr source))))) (reverse (car (cdr (car (cdr (cdr source)))))))))
		source
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

(define (scoping sym obj)
	(define (find sym obj)
		(define buffer (open ".buffer" 'write))
		(define oldOutput (setPort buffer))
		(ppTable obj)
		(setPort oldOutput)
		(close buffer)
		
		(define buffer (open ".buffer" 'read))
		(define oldInput (setPort buffer))

		;now we have the ppTable
		(readLine) ;eliminate first line
		(define (find-iter sym found)
			(if (or (eof?) found)
				found
				(begin
					(if (== (symbol (readToken)) sym)
						(define found #t)
					)
					(readLine) ;rest of the line
					(find-iter sym found)
				)
			)
		)
		(define found (find-iter sym #f))

		(setPort oldInput)
		(close buffer)

		found
	)
	
	(if (find sym obj)
		'bound
		(begin
		
			;now try in __context
			(define (findInContext sym obj found)
				(if (or (nil? (dot obj __context)) found)
					found
					(findInContext sym (dot obj __context) (find sym (dot obj __context)))
				)
			)

			(if (findInContext sym obj #f)
				'free
				'undefined
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
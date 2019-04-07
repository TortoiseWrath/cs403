(define (merge a b)
	(cond
		((nil? a) b)
		((nil? b) a)
		((< (length (car a)) (length (car b)))
			(cons (car a) (merge (cdr a) b))
		)
		(else (cons (car b) (merge a (cdr b))))
	)
)

(define (powerSet set)
	(if (nil? set)
		'(())
		(let 
			((rest (powerSet (cdr set)))) 
			(merge 
				rest 
				(map 
					(lambda (subset) 
						(cons (car set) subset)
					) 
					rest
				)
			)
		)
	)
)

(define (main)
	(setNilDisplay 'nil)
	(setPort (open (getElement ScamArgs 1) 'read))
	(define env this)
    (define (iter expr)
         (if (not (eof?)) (begin (eval expr env) (iter (readExpr))))
         )
    (iter (readExpr))
)

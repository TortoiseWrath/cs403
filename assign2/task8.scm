(define (node value left right)
	(define (display) (print value))
	this
)

(define (newBST value)
	(node value nil nil)
)

(define (displayBST root)
	(define (iter root indent)
		(if (valid? root)
			(begin
				(iter (root'right) (string+ indent "    "))
				(print indent)
				((root'display))
				(println)
				(iter (root'left) (string+ indent "    "))
			)
		)
	)
	(iter root "")
)

(define (insertBST root value)
	(cond
		((nil? root)
			(newBST value)
		)
		((< value (root'value))
			(node
				(root'value)
				(insertBST (root'left) value)
				(root'right)
			)
		)
		(else
			(node
				(root'value)
				(root'left)
				(insertBST (root'right) value)
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

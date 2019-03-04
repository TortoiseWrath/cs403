(define (spaces n)
	(if (== n 0)
		""
		(string+
			" "
			(spaces (- n 1))
		)
	)
)

(define (crazyTriangle l r)
	(define (crazyTriangleElement row col)
		(cond
			((== col 1) l)
			((== col row) r)
			(else (+
				(crazyTriangleElement (- row 1) (- col 1))
				(crazyTriangleElement (- row 1) col)
			))
		)
	)

	(define (crazyTriangleRowFrom row left)
		(if (== row left)
			(string (crazyTriangleElement row left))
			(string+
				(string (crazyTriangleElement row left))
				" "
				(crazyTriangleRowFrom row (+ left 1))
			)
		)
	)

	(define (crazyTriangleRow n row)
		(string+
			(spaces (- n row))
			(crazyTriangleRowFrom row 1)
		)
	)

	(define (crazyTriangleRows n last)
		(if (== last 0)
			""
			(string+
				(crazyTriangleRows n (- last 1)) ; up to previous row
				(crazyTriangleRow n last) ; last row
				"\n"
			)
		)
	)

	(lambda (n) 
		(print (crazyTriangleRows n n))
	)
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define l (readInt))
	(define r (readInt))
	(define n (readInt))
	(println "((crazyTriangle " l " " r ") " n ")")
	((crazyTriangle l r) n)
)
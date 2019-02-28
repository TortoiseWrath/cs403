(define pi 3.14159265358979323846)

(define (cyan x)
	(int (+ 0.00000001 
		(* 255 (cos (* (/ pi 200) x)))
	))
)

(define (yellow x) 
	(int (+ 0.00000001
		(* 255 (+ 1 (* -1  (sin (* (/ pi 100) x)))))
	))
)

(define (magenta x) 
	(int (+ 0.00000001
		(* (/ (real 255) 2) (+ 1 (cos (* x (/ (* pi 3) 200)))))
	))
)

(define (hex x) 
	(define hexes "0123456789ABCDEF")
	(string+
		(getElement hexes (/ x 16))
		(getElement hexes (% x 16))
	)
)

(define (cym x)
	(string+
		"#"
		(hex (cyan x))
		(hex (yellow x))
		(hex (magenta x))
	)
)

(define (inspectLusth name f x)
	(println (string+
		"(" name " " x ") is " (f x)
	))
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
    (define x (readExpr))
	(inspectLusth "cyan" cyan x)
	(inspectLusth "yellow" yellow x)
	(inspectLusth "magenta" magenta x)
	(inspectLusth "cym" cym x)
)
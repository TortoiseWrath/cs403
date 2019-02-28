(define (mandelbrot threshold)
	(define (mandelthresh x y)
		(define (recurse r s n rec)
			(define r2 (+ (- (* r r) (* s s)) x))
			(define s2 (+ (* 2.0 r s) y))
			(define n2 (+ n 1))
			(if (== n threshold)
				0
				(if (> (+ (* r2 r2) (* s2 s2)) 4)
					n2
					(rec r2 s2 n2 rec)
				)
			)
		)
		(recurse 0.0 0.0 0 recurse)
	)
	mandelthresh
)

(define (main) 
	(setPort (open (getElement ScamArgs 1) 'read))
    (define threshold (readInt))
	(define x (readReal))
	(define y (readReal))
	(println (string+
		"((mandelbrot " threshold ") " (fmt "%.10f" x) " " (fmt "%.10f" y) ") is " ((mandelbrot threshold) x y)
	))
)
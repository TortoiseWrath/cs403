(define (sdisplay n str)
	(define (iter i str)
		(if (= n i)
			(print "...)")
			(begin
				(print (stream-car str) ",")
				(iter (+ i 1) (stream-cdr str))
			)
		)
	)
	(print "(")
	(iter 0 str)
)

(define (mystery x)
	(define (mys i num denom)
		(define n (* num x x))
		(define d (* denom (* i 2) (- (* i 2) 1)))
		(if (= 0 (% i 2))
			(define sign 1)
			(define sign -1)
		)
		(cons-stream
			(* sign (/ n d))
			(mys (+ i 1) n d)
		)
	)
	(cons-stream 1.0 (mys 1 1.0 1.0))
)

(define (ps-mystery x)
	(define (ps s prev)
		(define sum (+ (stream-car s) prev))
		(cons-stream sum (ps (stream-cdr s) sum))
	)
	(ps (mystery x) 0.0)
)

(define (euler-transform s) 
	(define (square x) (* x x))
	(define s0 (stream-car s))
	(define s1 (stream-car (stream-cdr s)))
	(define s2 (stream-car (stream-cdr (stream-cdr s))))	
	(if (= s1 s2)
		(cons-stream s1 (euler-transform (stream-cdr s)))
		(cons-stream
			(- s2 (/ (square (- s2 s1)) (+ s0 (* -2 s1) s2)))
			(euler-transform (stream-cdr s))
		)
	)
)

(define (acc-mystery x)
	(euler-transform (ps-mystery x))
)

(define (super-mystery x)
	(define (superaccel s)
		(cons-stream (stream-car s) (superaccel (euler-transform (stream-cdr s))))
	)
	(superaccel (ps-mystery x))
)

(define (symbolic-mystery)
	(println "(mystery x) is $\\cos x$")
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
	(define env this)
    (define (iter expr)
         (if (not (eof?)) (begin (eval expr env) (iter (readExpr))))
         )
    (iter (readExpr))
)
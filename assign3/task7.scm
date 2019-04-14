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
		(define d (* denom (* i 2) (- (* i 2) 1))
		(cons-stream
			(* 
				(if (= 0 (% i 2)) 1 -1)
				(/ n d)
			)
			(mys (+ i 1) n d)
		)
	)
	(cons-stream 1 (mys 1 1 1))
)

(define (ps-mystery x)

)

(define (acc-mystery x)

)

(define (super-mystery x)

)

(define (symbolic-mystery)
	(println "i dunno")
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
	(define env this)
    (define (iter expr)
         (if (not (eof?)) (begin (eval expr env) (iter (readExpr))))
         )
    (iter (readExpr))
)
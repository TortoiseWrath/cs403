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

(define (ramanujan)
	(define (cube x) (* x x x))
	(define (weight i j) (+ (cube i) (cube j)))
	(define (merge s1 s2)
		(if
			(<
				(weight (car (stream-car s1)) (cdr (stream-car s1)))
				(weight (car (stream-car s2)) (cdr (stream-car s2)))
			)
			(cons-stream (stream-car s1) (merge (stream-cdr s1) s2))
			(cons-stream (stream-car s2) (merge s1 (stream-cdr s2)))
		)
	)
	(define (stream-map proc s)
		(cons-stream (proc (stream-car s)) (stream-map proc (stream-cdr s)))
	)
	(define (weighted-pairs s1 s2)
		(cons-stream
			(cons (stream-car s1) (stream-car s2))
			(merge
				(stream-map (lambda (x) (cons (stream-car s1) x)) (stream-cdr s2))
				(weighted-pairs (stream-cdr s1) (stream-cdr s2))
			)
		)
	)
	(define (weigh pair)
		(weight (car pair) (cdr pair))
	)
	(define (integers)
		(define (integers-from n)
			(cons-stream n (integers-from (+ n 1)))
		)
		(integers-from 1)
	)
	(define (ram pairs)
		(if (= (weigh (stream-car pairs)) (weigh (stream-car (stream-cdr pairs))))
			(cons-stream (weigh (stream-car pairs)) (ram (stream-cdr pairs)))
			(ram (stream-cdr pairs))
		)
	)
	(ram (weighted-pairs (integers) (integers)))
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
	(define env this)
    (define (iter expr)
         (if (not (eof?)) (begin (eval expr env) (iter (readExpr))))
         )
    (iter (readExpr))
)
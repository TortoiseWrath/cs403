; Stack is a list; first element is the size
(define (Stack) (list 0))
; Queue is a size and two stacks
(define (Queue) (list 0 (Stack) (Stack)))

(define (push s v)
	(cons 
		(+ (car s) 1) ;size
		(cons
			v ;new value
			(cdr s) ;old stack
		)
	)
)

(define (pop s)
	(cons
		(- (car s) 1) ;size
		(cdr (cdr s))
	)
)

(define (speek s)
	(car (cdr s))
)

(define (ssize s)
	(car s)
)

(define (enqueue q v)
	(list
		(+ (car q) 1) ;size
		(push (car (cdr q)) v) ;push to first stack
		(car (cdr (cdr q))) ;do not touch second stack
	)
)

(define (dequeue q)
	(define stack1 (car (cdr q)))
	(define stack2 (car (cdr (cdr q))))
	(if (== (ssize stack2) 0)
		(begin
			(define stack2 (cons (ssize stack1) (reverse (cdr stack1))))
			(define stack1 (Stack))
		)
	)
	(list
		(- (car q) 1) ;size
		stack1
		(pop stack2)
	)
)

(define (qpeek q)
	(define stack1 (car (cdr q)))
	(define stack2 (car (cdr (cdr q))))
	(if (== (ssize stack2) 0)
		(define stack2 (cons (ssize stack1) (reverse (cdr stack1))))
	)
	(speek stack2)
)

(define (qsize q)
	(car q)
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
	(define env this)
    (define (iter expr)
         (if (not (eof?)) (begin (eval expr env) (iter (readExpr))))
         )
    (iter (readExpr))
)
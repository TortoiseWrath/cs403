(define (deque)
	(define size 0)
	(define q (cons '() '()))

	(define enqueueFront (lambda (value)
		(let ((new (cons value (cons '() (car q)))))
			(begin
				(if (= size 0)
					(set-cdr! q new)
					(set-car! (cdr (car q)) new)
				)
				(set-car! q new)
				(set 'size (+ size 1))
				value
			)
		)
	))
	(define enqueueBack (lambda (value)
		(let ((new (cons value (cons (cdr q) '()))))
			(begin
				(if (= size 0)
					(set-car! q new)
					(set-cdr! (cdr (cdr q)) new)
				)
				(set-cdr! q new)
				(set 'size (+ size 1))
				value
			)
		)
	))
	(define enqueueIndex (lambda (index value)
		(cond
			((= index size)
				(enqueueBack value)
			)
			((= index 0)
				(enqueueFront value)
			)
			(else
				(define (seekToIndex target i pointer)
					(if (= target i)
						pointer
						(seekToIndex target (+ i 1) (cdr (cdr pointer)))
					)
				)
				(let 
					(
						(old (seekToIndex (- index 1) 0 (car q)))
						(new (cons value (cons '() '())))
					)
					(set-car! (cdr new) old) ;i->left is old
					(set-cdr! (cdr new) (cdr (cdr old))) ;i->right is old->right
					(set-car! (cdr (cdr (cdr old))) new) ;i+1->left is new
					(set-cdr! (cdr old) new) ;i-1->right is new
				)
				(set 'size (+ size 1))
				value
			)
		)
	))
	(define dequeueFront (lambda ()
		(let ((old (car q)))
			(begin
				(set-car! q (cdr (cdr old)))
				(set-car! (cdr (car q)) nil)
				(set 'size (- size 1))
				(car old)
			)
		)
	))
	(define dequeueBack (lambda ()
		(let ((old (cdr q)))
			(begin
				(set-cdr! q (car (cdr old)))
				(set-cdr! (cdr (cdr q)) nil)
				(set 'size (- size 1))
				(car old)
			)
		)
	))
	(define dequeueIndex (lambda (index)
		(cond
			((= index (- size 1))
				(dequeueBack)
			)
			((= index 0)
				(dequeueFront)
			)
			(else
				(define (seekToIndex target i pointer)
					(if (= target i)
						pointer
						(seekToIndex target (- i 1) (car (cdr pointer)))
					)
				)
				(let ((r (seekToIndex (+ index 1) (- size 1) (cdr q))))
					(begin
						(define dequeued (car (car (cdr r))))
						(set-car! (cdr r) (car (cdr (car (cdr r)))))
						(set-cdr! (cdr (car (cdr r))) r)
						(set 'size (- size 1))
						dequeued
					)
				)
			)
		)
	))
	(define display (lambda ()
		(print "[")
		(if (> size 0)
			(begin
				(print (car (car q)))
				(define (displayNext l)
					(cond
						((nil? (cdr (cdr l)))
							7 ;return
						)
						(else
							(print ",")
							(print (car (cdr (cdr l))))
							(displayNext (cdr (cdr l)))
						)
					)
				)
				(displayNext (car q))
			)
		)
		(print "]")
	))
	(define peekFront (lambda ()
		(car (car q))
	))
	(define peekBack (lambda ()
		(car (cdr q))
	))

	this
)

(define (main)
	(setPort (open (getElement ScamArgs 1) 'read))
	(define env this)
    (define (iter expr)
         (if (not (eof?)) (begin (eval expr env) (iter (readExpr))))
         )
    (iter (readExpr))
)
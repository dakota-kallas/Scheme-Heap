#lang racket
; Author: Dakota Kallas
; CS 421 Homework #2

; Returns an empty heap.
(define (heap-create)
  '())

; Returns #t if heap h is empty and #f otherwise.
(define (heap-is-empty? h)
  (null? h))

; Creates a heap with the root v.
(define (make-heap v l r)
  (list v l r))

; Returns the left node of the heap.
(define (left h)
  (cadr h))

; Returns the right node of the heap.
(define (right h)
  (caddr h))

; Returns the size of heap h (i.e. the number of values in the heap)
(define (heap-size h)
  (cond ((null? h) 0)
        (else (+ (heap-size (left h)) (heap-size (right h)) 1))))

; Returns the path to the next insertion.
(define (insertion-path n)
  (cond ((zero? n) '())
        (else (cons (remainder n 2) (insertion-path (quotient n 2))))))

; Inserts a value x in heap h following path p according to the function f.
(define (heap-path-insert h f x p)
  (cond ((null? h) (make-heap x '() '()))
        (else (let ((root (car h)))
                (cond ((f x root)
                       (cond ((equal? (cadr p) 0) (make-heap x (heap-path-insert (left h) f root (cdr p)) (right h)))
                             (else (make-heap x (left h) (heap-path-insert (right h) f root (cdr p))))))
                      (else
                       (cond ((equal? (cadr p) 0) (make-heap root (heap-path-insert (left h) f x (cdr p)) (right h)))
                             (else (make-heap root (left h) (heap-path-insert (right h) f x (cdr p)))))))))))

; Returns the heap that results from inserting x into heap h.
(define (heap-insert h f x)
  (heap-path-insert h f x (reverse (insertion-path (+ 1 (heap-size h))))))

; Returns the highest-priority (smallest according to heap-insert predicate f) value in heap h.
(define (heap-peek h)
  (car h))

; Returns true if heap h contains element x as defined by the eq predicate and false otherwise.
(define (heap-contains h eq x)
  (cond ((null? h) #f)
        ((eq x (car h)) #t)
        (else (or (heap-contains (left h) eq x) (heap-contains (right h) eq x)))))

; Returns the heap that results from adding each element in list xs to an empty heap in the order they occur in xs using f as the heap-insert predicate.
(define (list->heap xs f)
  (foldl (lambda (n h) (heap-insert h f n)) (heap-create) xs))

(provide list->heap heap-contains heap-peek heap-insert heap-path-insert insertion-path heap-size right left make-heap heap-is-empty? heap-create)
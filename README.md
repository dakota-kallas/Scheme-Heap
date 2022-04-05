# Scheme-Heap
A Scheme implementation of a heap "class".

_Author: Dakota Kallas_

### Description

A heap is a binary tree such that the root contains the highest-priority value in the heap. In addition, that property holds recursively for every other node in the heap - in the sense that every node has the highest priority value of all of that nodes descendants. In this program, I implemented the heap as a complete binary tree using the Scheme data-structure given below.
1. The empty list is the empty heap.
2. Otherwise a heap is a list of exactly three elements. The first element is the root value, the second element is the left sub-tree (also a heap) and the third element is the right sub-tree (also a heap).

## Implementation:
1. `(heap-create)` Returns an empty heap.
2. `(heap-is-empty? h)` Returns `#t` if heap `h` is empty and `#f` otherwise.
3. `(heap-size h)` Returns the size of heap `h` (i.e. the number of values in the heap)
4. `(heap-insert h f x)` Returns the heap that results from inserting `x` into heap `h`. Function `f` is a predicate that accepts two elements of the type contained in the heap and returns `#t` if the left operand is less than the right.
5. `(heap-peek h)` Returns the highest-priority (smallest according to heap-insert predicate `f`) value in heap `h`.
6. `(heap-contains h eq x)` Returns `#t` if heap `h` contains element `x` as defined by the `eq` predicate and `#f` otherwise. Function `eq` is a predicate that accepts two elements of the type contained in the heap and returns `#t` if the two elements are equal and `#f` otherwise.
7. `(list->heap xs f)` Returns the heap that results from adding each element in list `xs` to an empty heap in the order they occur in `xs` using `f` as the heap-insert predicate.
   
### Examlple inputs & outputs:
1. (list->heap '(3 1 5 9 8 2 7 4 6) <) => (1 (3 (4 (9 () ()) (6 () ())) (8 () ())) (2 (5 () ()) (7 () ())))
2. (list->heap '(3 1 5 9 8 2 7 4 6) >) => (9 (8 (6 (1 () ()) (4 () ())) (5 () ())) (7 (2 () ()) (3 () ())))
3. (list->heap '(d e q w b r t) (lambda (x y) (string<? (symbol->string x) (symbol->string y)))) => (b (d (w () ()) (e () ())) (q (r () ()) (t () ())))
4. (list->heap '((1 3) (5 12 0 5) (a) (#t #t #t #t)) (lambda (x y) (< (length x) (length y)))) => ((a) ((5 12 0 5) ((#t #t #t #t) () ()) ()) ((1 3) () ()))

(load "./register_machine_with_trace3.scm")

;; (b)
;;
;; (define (count-leaves tree)
;;   (define (count-ter tree n)
;;     (cond ((null? tree) n)
;;           ((not (pair? tree)) (+ n 1))
;;           (else (count-iter (cdr tree)
;;                             (count-iter (car tree) n))))))
;; (count-iter tree 0)

(define count-leaves-machine-a
  (make-machine
   '(continue tree n is-pair car-tree cdr-tree)
   (list
    (list 'null? null?)
    (list 'pair? pair?)
    (list '+ +)
    (list 'not not)
    (list 'car car)
    (list 'cdr cdr))
   '(
     start
       (assign n (const 0))
     count-leaves-loop
       (test (op null?) (reg tree))
       (branch (label cdr-tree-null-check))
       (assign is-pair (op pair?) (reg tree))
       (test (op not) (reg is-pair)) ;; ペアでなければカウント
       (branch (label increment-leaves-count))
       (assign cdr-tree (op cdr) (reg tree))
       (save cdr-tree)
       (assign tree (op car) (reg tree))
       (goto (label count-leaves-loop))
     increment-leaves-count
       (assign n (op +) (reg n) (const 1))
       (restore tree)
       (goto (label count-leaves-loop))
     cdr-tree-null-check
       (restore tree)
       (test (op null?) (reg tree))
       (branch (label count-leaves-done))
       (goto (label count-leaves-loop))
     count-leaves-done)))

;; (count-leaves-machine-a 'trace-on)
;; ((count-leaves-machine-a 'register-trace-on) 'val)
;; ((count-leaves-machine-a 'register-trace-on) 'cdr-tree)
;; ((count-leaves-machine-a 'register-trace-on) 'tree)
((count-leaves-machine-a 'stack) 'initialize)

(set-register-contents! count-leaves-machine-a
                        'tree
                        (list (list 1 2) (list 3 (list 4 5)))) ;; leaves-num -> 5
(start count-leaves-machine-a)
(print "(b) leaves =>" (get-register-contents count-leaves-machine-a 'n))
((count-leaves-machine-a 'stack) 'print-statistics)



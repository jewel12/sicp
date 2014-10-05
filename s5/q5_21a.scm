(load "./register_machine_with_trace3.scm")

;; (a)
;;
(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else (+ (count-leaves (car tree))
                 (count-leaves (cdr tree))))))

(define count-leaves-machine-a
  (make-machine
   '(continue tree val cdr-val is-pair car-tree cdr-tree)
   (list
    (list 'null? null?)
    (list 'pair? pair?)
    (list '+ +)
    (list 'not not)
    (list 'car car)
    (list 'cdr cdr))
   '(
     start
       (assign continue (label count-leaves-done))
       (assign val (const 0))
     count-leaves-loop
       (test (op null?) (reg tree))
       (branch (label null-tree))
       (assign is-pair (op pair?) (reg tree))
       (test (op not) (reg is-pair)) ;; ペアでなければカウント
       (branch (label count-leaf))
       (save continue)
       (assign continue (label count-car-tree))
       (save tree)
       (assign tree (op car) (reg tree))
       (goto (label count-leaves-loop))
     null-tree
       (assign val (const 0))
       (goto (reg continue))
     count-leaf
       (assign val (const 1))
       (goto (reg continue))
     count-car-tree
       (restore tree)
       (assign tree (op cdr) (reg tree))
       (save val) ;; car-tree の分
       (assign continue (label count-cdr-tree))
       (goto (label count-leaves-loop))
     count-cdr-tree
       (assign cdr-val (reg val)) ;; cdr-tree 分
       (restore val) ;; car-tree 分
       (assign val (op +) (reg val) (reg cdr-val))
       (restore continue)
       (goto (reg continue))
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
(print "(a) leaves =>" (get-register-contents count-leaves-machine-a 'val))
((count-leaves-machine-a 'stack) 'print-statistics)



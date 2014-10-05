(load "./register_machine_with_trace3.scm")

;; (b)
;;
;; (define (append! x y)
;;   (set-cdr! (last-pair x) y)
;;   x)
  
(define append!-machine
  (make-machine
   '(continue x car-x cdr-x y)
   (list
    (list 'null? null?)
    (list 'set-cdr! set-cdr!)
    (list 'cons cons)
    (list 'car car)
    (list 'cdr cdr))
   '(
     start
       (save x)
     append!-loop
       (assign cdr-x (op cdr) (reg x))
       (test (op null?) (reg cdr-x))
       (branch (label last-pair))
       (assign x (op cdr) (reg x))
       (goto (label append!-loop))
     last-pair
       (perform (op set-cdr!) (reg x) (reg y))
       (restore x)
       (goto (label append!-done))
     append!-done  )))

;; (append-machine 'trace-on)
;; ((append-machine 'register-trace-on) 'res)
;; ((append-machine 'register-trace-on) 'x)

(set-register-contents! append!-machine 'x (list 1 2))
(set-register-contents! append!-machine 'y (list 3 (list 4 5)))
(start append!-machine)
(print "(append!) x =>" (get-register-contents append!-machine 'x))
(print "(append!) y =>" (get-register-contents append!-machine 'y))

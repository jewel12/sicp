(load "./register_machine_with_trace3.scm")

;; (a)
;;
;; (define (append x y)
;;   (if (null? x)
;;       y
;;       (cons (car x) (append (cdr x) y))))

(define append-machine
  (make-machine
   '(continue x car-x cdr-x y res)
   (list
    (list 'null? null?)
    (list 'cons cons)
    (list 'car car)
    (list 'cdr cdr))
   '(
     start
       (assign continue (label append-done))
     append-loop
       (test (op null?) (reg x))
       (branch (label null-x))
       (save continue)
       (assign continue (label append))
       (save x)
       (assign x (op cdr) (reg x))
       (goto (label append-loop))
     null-x
       (assign res (reg y))
       (goto (reg continue))
     append
       (restore x)
       (restore continue)
       (assign car-x (op car) (reg x))
       (assign res (op cons) (reg car-x) (reg res))
       (goto (reg continue))
     append-done)))

;; (append-machine 'trace-on)
;; ((append-machine 'register-trace-on) 'res)
;; ((append-machine 'register-trace-on) 'x)

(set-register-contents! append-machine 'x (list 1 2))
(set-register-contents! append-machine 'y (list 3 (list 4 5)))
(start append-machine)
(print "(append) re =>" (get-register-contents append-machine 'res))
(print "(append) x =>" (get-register-contents append-machine 'x))
(print "(append) y =>" (get-register-contents append-machine 'y))

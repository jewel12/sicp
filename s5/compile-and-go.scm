(load "./register_machine_with_trace3.scm")
(load "./operations.scm")
(load "./eceval-for-compiler.scm")
(load "./compiler.scm")

(define the-global-environment '())

(define (compile-and-go expression)
  (let ((instructions
         (assemble (statements
                    (compile expression 'val 'return))
                   eceval)))
    (set! the-global-environment (setup-environment))
    (set-register-contents! eceval 'val instructions)
    (set-register-contents! eceval 'flag true)
    (start eceval)))

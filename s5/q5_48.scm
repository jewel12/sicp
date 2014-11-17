;; q5.48
(load "./compile-and-go.scm")

;; setup-environment せずに前の環境を引き継いで eceval を作るようにしただけ

(define (compile-and-run expression)
  (let ((instructions
         (assemble (statements
                    (compile expression 'val 'return))
                   eceval)))
    ;; (set! the-global-environment (setup-environment))
    (set-register-contents! eceval 'val instructions)
    (set-register-contents! eceval 'flag true)
    (start eceval)))

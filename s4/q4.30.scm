(load "./eval-s4.2.2.scm")

; print
(define input-prompt ";;; L-Eval input:")
(define output-prompt ";;; L-Eval value:")

(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output
            (actual-value input the-global-environment)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))

(define (prompt-for-input string)
 (newline) (newline) (display string) (newline))

(define (announce-output string)
 (newline) (display string) (newline))

(define (user-print object)
 (if (compound-procedure? object)
  (display (list 'compound-procedure
                 (procedure-parameters object)
                 (procedure-body object)
                 '<procedure-env>))
  (display object)))

(define the-global-environment (setup-environment))

;; ;; Cy の提案
;; (define (eval-sequence exps env)
;;   (cond ((last-exp? exps) (eval (first-exp exps) env))
;;         (else (actual-value (first-exp exps) env)
;;               (eval-sequence (rest-exps exps) env))))

(driver-loop)

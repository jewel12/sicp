(load "./eval-logic.scm")

(define input-prompt ";;; Query input:")
(define output-prompt ";;; Query results:")

(define (query-driver-loop)
  (prompt-for-input input-prompt)
  (let ((q (query-syntax-process (read)))) ;; 効率的に処理が出来る形へ式を構文的に変換
    (cond ((assertion-to-be-added? q)
           (add-rule-or-assertion! (add-assertion-body q))
           (newline)
           (display "Assertion added to data base.")
           (query-driver-loop))
          (else
           (newline)
           (display output-prompt)
           (display-stream
            (stream-map
             (lambda (frame)
               (instantiate q
                             frame
                             (lambda (v f)
                               (contract-question-mark v)))) ;; 未束縛で残っている変数を印字前に入力の表現へ逆変換
             (qeval q (singleton-stream '()))))
           (query-driver-loop)))))

;; 式の具体化
(define (instantiate exp frame unbound-var-handler)
  (define (copy exp)
    (cond ((var? exp)
           (let ((binding (binding-in-frame exp frame)))
             (if binding
                 (copy (binding-value binding))
                 (unbound-var-handler exp frame)))) ;; 変数が具体化できない時に取る行動
          ((pair? exp)
           (cons (copy (car exp)) (copy (cdr exp))))
          (else exp)))
  (copy exp))

(define (prompt-for-input string)
 (newline) (newline) (display string) (newline))

(query-driver-loop)

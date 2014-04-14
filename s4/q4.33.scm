;; 現在の評価器ではアトムとクォートされたリストの区別がついていないので
;; '(1 2 3) のような表現をリストとして扱う必要がある。

;; 元のtext-of-quotation
;; (define (text-of-quotation exp) (cadr exp))

;; また、4.2.3でノンストリクトであるようなcons(遅延評価器で再定義したcons)を使いたいので
;; '(1 2 3) は (cons 1 (cons 2 (cons 3 '()))) と表現したい

;; quotedされてるのでquoteを外すためにcadrしないといけない

;; (define (text-of-quotation exp env)
;;   (let ((unquoted (cadr exp)))
;;     (if (pair? unquoted)
;;         (eval #?=(convert-to-cons unquoted) env)
;;         unquoted)))

;; (define (convert-to-cons list-exp)
;;   (if (null? list-exp)
;;       '()
;;       (list 'cons (car list-exp) (convert-to-cons (cdr list-exp)))))

(load "./eval-q4.33.scm")

;; 3章のcons-streamは (cons a (delay b)) となっているので
;; (cons-stream x y) をすると x を評価する必要がある

;; 4.2.3では
;; (define (cons x y)
;;   (lambda (m) (m x y))

;; の定義より(cons x y)をしてもxは評価されない
;; なので、xとyが未定義の状態でも(cons x y)が実行できる

;; 脚注41より、遅延木というものが作れる
;; Hughes, R. J. M. 1990. Why functional programming matters. In Research Topics in Functional Programming, edited by David Turner. Reading, MA: Addison-Wesley, pp. 17-42.
;; http://www.cse.chalmers.se/~rjmh/Papers/whyfp.pdf
;; 無限に深い二分木が作れるとか


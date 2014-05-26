(define (require p)
  (if (not p) (amb)))
(define (or a b)
  (if a true (if b true false)))
(define (and a b)
  (if a (if b true false) false))
(define (xor a b)
  (or (and a (not b))
      (and b (not a))))

;; 4.42
Betty 「(A: Kittyは試験が二番)で(B: 私は三番でした)」

Aが正しい時はBは嘘、Bが正しいときはAが嘘、AとBが正しいということはない。
という点で彼女らの発言はXORで表せる。

(define (examination-results-order)
  (let ((betty (amb 1 2 3 4 5))
        (ethel (amb 1 2 3 4 5))
        (joan (amb 1 2 3 4 5))
        (kitty (amb 1 2 3 4 5))
        (mary (amb 1 2 3 4 5)))
    (require
     (distinct? (list betty ethel joan kitty mary)))
    (require (xor (= kitty 2) (= betty 3)))
    (require (xor (= ethel 1) (= joan 2)))
    (require (xor (= joan 3) (= ethel 5)))
    (require (xor (= kitty 2) (= mary 4)))
    (require (xor (= mary 4) (= betty 1)))
    (list (list 'betty betty)
          (list 'ethel ethel)
          (list 'joan joan)
          (list 'kitty kitty)
          (list 'mary mary))))

(define (require p)
  (if (not p) (amb)))
(define (an-integer-between low high)
  (require (< low high))
  (amb low (an-integer-between (+ low 1) high)))

;; q4.35
(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high)))
    (let ((j (an-integer-between i high)))
      (let ((k (an-integer-between j high)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))

(define (an-integer-between low high)
  (require (< low high))
  (amb low (an-integer-between (+ low 1) high)))

(a-pythagorean-triple-between 2 50)

;; q4.36
解がなかったら無限に継続するから終わらない

;; q4.37

(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high))
        (hsq (* high high)))
    (let ((j (an-integer-between i high)))
      (let ((ksq (+ (* i i) (* j j))))
        (require (>= hsq ksq))
        (let ((k (sqrt ksq)))
          (require (integer? k))
          (list i j k))))))

(a-pythagorean-triple-between 2 50)

4.35は総当りで、37の方が効率が良い。

以下のようにして調べる可能性の数を減らしているからである:

* 37はi*i+j*jがhighの二乗を超えたら、それを満たすkは存在しないので探索しないようにしている。
* iとjが決まった時点でkも決定するので、kの探索は行わない
* また、q4.35より、kは整数でなければならない

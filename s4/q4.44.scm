(define (require p)
  (if (not p) (amb)))
(define (map f l)
  (if (null? l)
      '()
      (cons (f (car l))
            (map f (cdr l)))))
(define (and a b)
  (if a (if b true false) false))

;; q4.44

;; 1,1 1,2 1,3 ...
;; 2,1 2,2 2,3 ...
;; ... (i, j) ...

(define (eight-queen)
  (define (c i j) (cons i j))

  (define (cols positions) (map (lambda (k) (cdr k)) positions))

  (define (safe? k positions)
    (and (distinct? (cols (cons k positions)))   ;; j軸で被らない
         (not (on-any-diagonals? k positions)))) ;; 対角線上にない

  (define (on-any-diagonals? k positions)
    (if (null? positions)
        false
        (if (on-diagonal? k (car positions))
            true
            (on-any-diagonals? k (cdr positions)))))

  (define (on-diagonal? k pos) ;; posとkのi軸での差とj軸での差が等しければ対角線上
    (= (abs (- (car k) (car pos)))
       (abs (- (cdr k) (cdr pos)))))

  ;; qの定義の時点でi軸で被らないようになっている
  (let ((q1 (amb (c 1 1) (c 1 2) (c 1 3) (c 1 4) (c 1 5) (c 1 6) (c 1 7) (c 1 8))))
    (let ((q2 (amb (c 2 1) (c 2 2) (c 2 3) (c 2 4) (c 2 5) (c 2 6) (c 2 7) (c 2 8))))
      (require (safe? q2 (list q1)))

      (let ((q3 (amb (c 3 1) (c 3 2) (c 3 3) (c 3 4) (c 3 5) (c 3 6) (c 3 7) (c 3 8))))
        (require (safe? q3 (list q1 q2)))

        (let ((q4 (amb (c 4 1) (c 4 2) (c 4 3) (c 4 4) (c 4 5) (c 4 6) (c 4 7) (c 4 8))))
          (require (safe? q4 (list q1 q2 q3)))

          (let ((q5 (amb (c 5 1) (c 5 2) (c 5 3) (c 5 4) (c 5 5) (c 5 6) (c 5 7) (c 5 8))))
            (require (safe? q5 (list q1 q2 q3 q4)))

            (let ((q6 (amb (c 6 1) (c 6 2) (c 6 3) (c 6 4) (c 6 5) (c 6 6) (c 6 7) (c 6 8))))
              (require (safe? q6 (list q1 q2 q3 q4 q5)))

              (let ((q7 (amb (c 7 1) (c 7 2) (c 7 3) (c 7 4) (c 7 5) (c 7 6) (c 7 7) (c 7 8))))
                (require (safe? q7 (list q1 q2 q3 q4 q5 q6)))

                (let ((q8 (amb (c 8 1) (c 8 2) (c 8 3) (c 8 4) (c 8 5) (c 8 6) (c 8 7) (c 8 8))))
                  (require (safe? q8 (list q1 q2 q3 q4 q5 q6 q7)))
                  (list q1 q2 q3 q4 q5 q6 q7 q8))))))))))

(eight-queen)

(define (require p)
  (if (not p) (amb)))
(define (or a b)
  (if a true (if b true false)))
(define (and a b)
  (if a (if b true false) false))
(define (xor a b)
  (or (and a (not b))
      (and b (not a))))

;; 4.43

;; daughter -> father
(define (lorna-father)
  (let ((gabrielle (amb 'moore 'dowing 'hall 'barnacle 'parker))
        (lorna (amb 'moore 'dowing 'hall 'barnacle 'parker))
        (rosalind (amb 'moore 'dowing 'hall 'barnacle 'parker))
        (melissa (amb 'moore 'dowing 'hall 'barnacle 'parker))
        (mary (amb 'moore 'dowing 'hall 'barnacle 'parker)))
    (require
     (distinct? (list gabrielle lorna rosalind melissa mary)))
    (require (eq? mary 'moore)) ;; Mary Ann Mooreより
    (require (not (eq? gabrielle 'barnacle)))
    (require (not (eq? lorna 'moore)))
    (require (not (eq? rosalind 'hall)))
    (require (not (eq? melissa 'downing)))
    (require (eq? melissa 'barnacle))
    (require (not (eq? gabrielle 'parker)))
    (require (or (and (eq? rosalind 'parker) (eq? gabrielle 'hall))
                 (and (eq? lorna 'parker) (eq? gabrielle 'moore))))
    (list (list 'lorna lorna)
          (list 'rosalind rosalind)
          (list 'melissa melissa)
          (list 'mary mary)
          (list 'gabrielle gabrielle))
))

Mooreだと言われなければ2通り

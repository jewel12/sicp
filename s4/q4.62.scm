;; q4.62

;; (last-pair (list 23 72 149 34))
;; (34)

(assert! (rule (last-pair (?x . ()) (?x))))
(assert! (rule (last-pair (?x . ?y) ?z)
               (last-pair ?y ?z)))

(last-pair (23 72 149 34) ?x)

;; ;;; Query results:
;; (last-pair (23 72 149 34) (34))

(last-pair (3) ?x)

;;; Query results:
;; (last-pair (3) (3))

(last-pair (1 2 3) ?x)

;; ;;; Query results:
;; (last-pair (1 2 3) (3))

(last-pair (2 ?x) (3))

;; ;;; Query results:
;; (last-pair (2 3) (3))

(last-pair ?x 3)

;; ;;; Query results:
;; (3) を最後のペアとするリストはいくらでもるので返ってこない

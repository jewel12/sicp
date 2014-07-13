;; q4.56

;; a. Ben Bitdiddle が監督している人のすべての名前と住所

(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?address))

;; ;; 出力
;; (and (supervisor (Tweakit Lem E) (Bitdiddle Ben))
;;      (address (Tweakit Lem E) (Boston (Bay State Road) 22)))
;; (and (supervisor (Fect Cy D) (Bitdiddle Ben))
;;      (address (Fect Cy D) (Cambridge (Ames Street) 3)))
;; (and (supervisor (Hacker Alyssa P) (Bitdiddle Ben))
;;      (address (Hacker Alyssa P) (Cambridge (Mass Ave) 78)))

;; b. 給料が Ben Bitdiddle のそれより少ない人のすべてと、その人達の給料と Ben Bitdiddle の給料

(and (salary (Bitdiddle Ben) ?bens_salary)
     (salary ?person ?salary)
     (lisp-value > ?salary ?bens_salary))

;; ;;; Query results:
;; (and (salary (Bitdiddle Ben) 60000) (salary (Scrooge Eben) 75000)
;;      (lisp-value > 75000 60000))
;; (and (salary (Bitdiddle Ben) 60000) (salary (Warbucks Oliver) 150000)
;;      (lisp-value > 150000 60000))

;; c. 計算機部門にいない人が監督している人すべてと、その監督者の名前と担当

;; できなかった
(and (supervisor ?person ?supervisor)
     (not (job ?supervisor (computer . ?type)))
     (job ?supervisor ?job))

;; ;;; Query results:
;; (and (supervisor (Aull DeWitt) (Warbucks Oliver))
;;      (not (job (Warbucks Oliver) (computer . ?type)))
;;      (job (Warbucks Oliver) (administration big wheel)))
;; (and (supervisor (Cratchet Robert) (Scrooge Eben))
;;      (not (job (Scrooge Eben) (computer . ?type)))
;;      (job (Scrooge Eben) (accounting chief accountant)))
;; (and (supervisor (Scrooge Eben) (Warbucks Oliver))
;;      (not (job (Warbucks Oliver) (computer . ?type)))
;;      (job (Warbucks Oliver) (administration big wheel)))
;; (and (supervisor (Bitdiddle Ben) (Warbucks Oliver))
;;      (not (job (Warbucks Oliver) (computer . ?type)))
;;      (job (Warbucks Oliver) (administration big wheel)))


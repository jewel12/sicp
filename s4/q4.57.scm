;; q4.57
(assert! (rule (same ?x ?x)))

(assert! (rule (same-job ?person-1 ?person-2)
               (and (job ?person-1 ?job-1)
                    (job ?person-2 ?job-2)
                    (same ?job-1 ?job-2))))

(assert! (rule (replace ?person-1 ?person-2)
               (and
                (or (and (job ?person-1 ?job-1)
                         (job ?person-2 ?job-2)
                         (can-do-job ?job-2 ?job-1))
                    (same-job ?person-1 ?person-2))
                (not (same ?person-1 ?person-2)))))

;; a. Cy D. Fect に代われるひとすべて

(replace (Fect Cy D) ?person)

;; ;;; Query results:
;; (replace (Fect Cy D) (Bitdiddle Ben))
;; (replace (Fect Cy D) (Hacker Alyssa P))


;; b. 誰かに代われて、その誰かのほうが多くの給料を貰っている人すべてと、両者の給料

(and (replace ?person ?replaceable)
     (salary ?person ?salary)
     (salary ?replaceable ?replaceable-salary)
     (lisp-value > ?replaceable-salary ?salary))

;; ;;; Query results:
;; (and (replace (Reasoner Louis) (Fect Cy D))
;;      (salary (Reasoner Louis) 30000)
;;      (salary (Fect Cy D) 35000)
;;      (lisp-value > 35000 30000))
;; (and (replace (Reasoner Louis) (Hacker Alyssa P))
;;      (salary (Reasoner Louis) 30000)
;;      (salary (Hacker Alyssa P) 40000)
;;      (lisp-value > 40000 30000))
;; (and (replace (Tweakit Lem E) (Bitdiddle Ben))
;;      (salary (Tweakit Lem E) 25000)
;;      (salary (Bitdiddle Ben) 60000)
;;      (lisp-value > 60000 25000))
;; (and (replace (Fect Cy D) (Bitdiddle Ben))
;;      (salary (Fect Cy D) 35000)
;;      (salary (Bitdiddle Ben) 60000)
;;      (lisp-value > 60000 35000))
;; (and (replace (Hacker Alyssa P) (Bitdiddle Ben))
;;      (salary (Hacker Alyssa P) 40000)
;;      (salary (Bitdiddle Ben) 60000)
;;      (lisp-value > 60000 40000))
;; (and (replace (Fect Cy D) (Hacker Alyssa P))
;;      (salary (Fect Cy D) 35000)
;;      (salary (Hacker Alyssa P) 40000)
;;      (lisp-value > 40000 35000))

;; q4.55

;; a. Ben Bitdiddle に監督されている人すべて

(supervisor ?x (Bitdiddle Ben))

;; ;;; Query results:
;; (supervisor (Tweakit Lem E) (Bitdiddle Ben))
;; (supervisor (Fect Cy D) (Bitdiddle Ben))
;; (supervisor (Hacker Alyssa P) (Bitdiddle Ben))

;; b. 経理部門(accounting division)のすべての人の名前と担当

(job ?x (accounting . ?type))

;; ;;; Query results:
;; (job (Cratchet Robert) (accounting scrivener))
;; (job (Scrooge Eben) (accounting chief accountant))

;; c. Slumerville に住んでいるすべての人の名前と住所

(address ?x (Slumerville . ?address))

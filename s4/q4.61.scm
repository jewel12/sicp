;; q4.61

(assert! (rule (?x next-to ?y in (?x ?y . ?u))))

(assert! (rule (?x next-to ?y in (?v . ?z))
               (?x next-to ?y in ?z)))

(?x next-to ?y (1 (2 3) 4))

;;; Query results:
;; (1 next-to (2 3) in (1 (2 3) 4)) とか出てきてほしいと思うのだけど、空

(?x next-to 1 in (2 1 3 1))

;; ;;; Query results:
;; (3 next-to 1 in (2 1 3 1))
;; (2 next-to 1 in (2 1 3 1))

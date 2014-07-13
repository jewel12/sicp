;; q4.63

(assert! (son Adam Cain))
(assert! (son Cain Enoch))
(assert! (son Enoch Irad))
(assert! (son Irad Mehujael))
(assert! (son Mehujael Methushael))
(assert! (son Methushael Lamech))
(assert! (wife Lamech Ada))
(assert! (son Ada Jabal))
(assert! (son Ada Jubal))

(assert! (rule (grandson ?grandfather ?grandson)
               (and (son ?father ?grandson)
                    (son ?grandfather ?father))))

;;; Query input:
(grandson ?grandfather ?grandson)

;; ;;; Query results:
;; (grandson Mehujael Lamech)
;; (grandson Irad Methushael)
;; (grandson Enoch Mehujael)
;; (grandson Cain Irad)
;; (grandson Adam Enoch)

(assert! (rule (son2 ?m ?s)
               (and (wife ?m ?w)
                    (son ?w ?s))))

;; ;;; Query results:
;; (son2 Lamech Jubal)
;; (son2 Lamech Jabal)

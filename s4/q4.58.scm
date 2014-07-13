;; q4.58
(assert! (rule (same ?x ?x)))

(assert! (rule (big-shot ?person)
               (and (job ?person (?department . ?type))
                    (supervisor ?person ?supervisor)
                    (not (job ?supervisor (?department . ?type2))))))

(and (big-shot ?person)
     (job ?person (?department . ?type)))

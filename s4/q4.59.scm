;; 4.59

;; Additional data

(assert! (meeting accounting (Monday 9am)))
(assert! (meeting administration (Monday 10am)))
(assert! (meeting computer (Wednesday 3pm)))
(assert! (meeting administration (Friday 1pm)))

(assert! (meeting whole-company (Wednesday 4pm)))

;; a. 金曜の朝にあるすべての会合を取得する質問

(meeting ?department (Friday . ?time))

;; b. ある人が出るべき会合を表す規則

(assert! (rule (meeting-time ?person ?day-and-time)
               (or (and (job ?person (?department . ?type))
                        (meeting ?department ?day-and-time))
                   (meeting whole-company ?day-and-time))))

;; c. Alyssaが水曜にでるべき会合を取得する質問

(meeting-time (Hacker Alyssa P) (Wednesday . ?time))

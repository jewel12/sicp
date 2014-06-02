;; q4.45

;; (parse '(the professor lectures to the student in the class with the cat))

;; 1
;; 猫といる教授は生徒に教室で講義する

;; 教授は - 講義をする - 生徒に
;;                     - 教室で
;;        - 猫といる
(sentence
 (simple-noun-phrase (article the)
                     (noun professor))
 (verb-phrase (verb-phrase (verb-phrase (verb lectures)
                                        (prep-phrase (prep to)
                                                     (simple-noun-phrase (article the)
                                                                         (noun student))))
                           (prep-phrase (prep in)
                                        (simple-noun-phrase (article the)
                                                            (noun class))))
              (prep-phrase (prep with)
                           (simple-noun-phrase (article the)
                                               (noun cat)))))

;; 2
;; 猫がいる教室にいる教授は、生徒に講義する

;; 教授は - 講義をする - 生徒に
;;        - 教室にいる - 猫がいる
(sentence
 (simple-noun-phrase (article the)
                     (noun professor))
 (verb-phrase (verb-phrase (verb lectures)
                           (prep-phrase (prep to)
                                        (simple-noun-phrase (article the)
                                                            (noun student))))
              (prep-phrase (prep in)
                           (noun-phrase (simple-noun-phrase (article the)
                                                            (noun class))
                                        (prep-phrase (prep with)
                                                     (simple-noun-phrase (article the)
                                                                         (noun cat)))))))


;; 3
;; 猫といる教授は、教室にいる生徒に講義する

;; 教授は - 講義する - 生徒に - 教室にいる
;;        - 猫といる
(sentence
 (simple-noun-phrase (article the)
                     (noun professor))
 (verb-phrase (verb-phrase (verb lectures)
                           (prep-phrase (prep to)
                                        (noun-phrase (simple-noun-phrase (article the)
                                                                         (noun student))
                                                     (prep-phrase (prep in)
                                                                  (simple-noun-phrase (article the)
                                                                                      (noun class))))))
              (prep-phrase (prep with)
                           (simple-noun-phrase (article the)
                                               (noun cat)))))

;; 4
;; 教授は、猫といてかつ教室にいる生徒に講義する

;; 教授は - 講義する - 生徒に - 教室にいる
;;                            - 猫といる
(sentence
 (simple-noun-phrase (article the)
                     (noun professor))
 (verb-phrase (verb lectures)
              (prep-phrase (prep to)
                           (noun-phrase (noun-phrase (simple-noun-phrase (article the)
                                                                         (noun student))
                                                     (prep-phrase (prep in)
                                                                  (simple-noun-phrase (article the)
                                                                                      (noun class))))
                                        (prep-phrase (prep with)
                                                     (simple-noun-phrase (article the)
                                                                         (noun cat)))))))


;; 5
;; 教授は猫がいる教室で生徒に講義する

;; 教授は - 講義する - 生徒に - 教室で - 猫がいる
(sentence
 (simple-noun-phrase (article the)
                     (noun professor))
 (verb-phrase (verb lectures)
              (prep-phrase (prep to)
                           (noun-phrase (simple-noun-phrase (article the)
                                                            (noun student))
                                        (prep-phrase (prep in)
                                                     (noun-phrase (simple-noun-phrase (article the)
                                                                                      (noun class))
                                                                  (prep-phrase (prep with)
                                                                               (simple-noun-phrase (article the)
                                                                                                   (noun cat)))))))))

;; q4.46
parse-wordが呼ばれると、*unparsed*から単語が削除される。

the student in the class with the cat learns

の単語を任意の順で解析するとして、the student を先に解析してしまうと名詞句全体the student in the class が手に入らない

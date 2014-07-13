;; q4.60.scm

(assert! (rule (lives-near ?person-1 ?person-2)
               (and (address ?person-1 (?town . ?rest-1))
                    (address ?person-2 (?town . ?rest-2))
                    (not (same ?person-1 ?person-2)))))

(lives-near ?person (Hacker Alyssa P))

(lives-near ?person-1 ?person-2)

;; 近くに住む人の対のそれぞれが２度ずつリストされる理由

(lives-near (Hacker Alyssa P) (Fect Cy D))
(lives-near (Fect Cy D) (Hacker Alyssa P))

person-1: (Hacker Alyssa P)
person-2: (Fect Cy D)

の場合(Hacker Alyssa P を person-1として検索した場合)と

person-1: (Fect Cy D)
person-2: (Hacker Alyssa P)

の場合(Fect Cy D を person-1として検索した場合)の区別が付けられている。

各対が一度しか現れないようにするには、lives-near に何かしら条件を付けなたさないといけない。
person が比較可能であれば person-1 と person-2 を比較することで対の重複を消すことができる。名前とかで比較できそう。

(assert! (rule (lives-near ?person-1 ?person-2)
               (and (address ?person-1 (?town . ?rest-1))
                    (address ?person-2 (?town . ?rest-2))
                    (not (same ?person-1 ?person-2))
                    (lisp-value > ?person-1 ?person-2))))

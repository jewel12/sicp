(define (require p)
  (if (not p) (amb)))

(define nouns '(noun student professor cat class))
(define verbs '(verb studies lectures eats sleeps))
(define articles '(article the a))

(define (parse-sentence)
  (list 'sentence
         (parse-noun-phrase)
         (parse-word verbs)))

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word)))

(define *unparsed* '())

(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*))
    sent))

(define prepositions '(prep for to in by with))

(define (parse-prepositional-phrase)
  (list 'prep-phrase
        (parse-word prepositions)
        (parse-noun-phrase)))

(define (parse-sentence)
  (list 'sentence
         (parse-noun-phrase)
         (parse-verb-phrase)))

(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

(define (parse-noun-phrase)
  (define (maybe-extend noun-phrase)
    (amb noun-phrase
         (maybe-extend (list 'noun-phrase
                             noun-phrase
                             (parse-prepositional-phrase)))))
  (maybe-extend (parse-simple-noun-phrase)))

;; q4.47

;; ;; original
;; (define (parse-verb-phrase)
;;   (define (maybe-extend verb-phrase)
;;     (amb verb-phrase
;;          (maybe-extend (list 'verb-phrase
;;                              verb-phrase
;;                              (parse-prepositional-phrase)))))
;;   (maybe-extend (parse-word verbs)))

(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))


;; (parse '(the cat eats)) は動く
;; (parse '(the cat)) は動かないparse-verb-phraesの無限ループになる
;; 1回目の(parse-word verbs)で失敗したらバックトラックし次の選択(list 'verb-phrase...)に移る
;; また(parse-verb-phrase)が呼ばれ、(parse-word verbs)が失敗し、また(parse-verb-phrase)が呼ばれ…と無限ループになる
;; (parse '(the cat eats))でもtry-againをし、バックトラックさせると無限ループになる

;; ambの中の式の順番を変えると、バックトラックとか関係なく無限ループするのは自明

;; (define (parse-verb-phrase)
;;   (amb (list 'verb-phrase
;;              (parse-verb-phrase)
;;              (parse-prepositional-phrase))
;;        (parse-word verbs)))

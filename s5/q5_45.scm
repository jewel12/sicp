(load "./compile-and-go.scm")

(compile-and-go
 '(define (factorial n)
    (if (= n 1)
        1
        (* (factorial (- n 1)) n))))

;;; EC-Eval input:
(factorial 1)
(total-pushes = 7 maximum-depth = 3)

;;; EC-Eval input:
(factorial 2)
(total-pushes = 13 maximum-depth = 5)

;;; EC-Eval input:
(factorial 3)
(total-pushes = 19 maximum-depth = 8)

;;; EC-Eval input:
(factorial 4)
(total-pushes = 25 maximum-depth = 11)

;;; EC-Eval input:
(factorial 5)
(total-pushes = 31 maximum-depth = 14)


;; 翻訳した factorial 
total-pushes = 6n + 1
maximum-depth = 3n - 1 (n=2 以降について言えば)

参考 https://github.com/suzuken/sicp/blob/master/chapter5/q5.27.scm
より、積極評価器での再帰的階乗では

total-pushes = 32n + 16
(6n + 1) / (32n + 16) 比率: 0.1875

maximum-depth = 5n + 3
(3n - 1) / (5n + 3) 比率: 0.6

;; b

((env continue) (val)
 ((assign val (op make-compiled-procedure) (label entry18) (reg env))
  (goto (label after-lambda19))
entry18
(assign env (op compiled-procedure-env) (reg proc))
(assign env (op extend-environment) (const (n)) (reg argl) (reg env))
(save continue)
(save env)
(assign proc #0=(op lookup-variable-value) (const =) . #1=((reg env)))
(assign val (const 1))
#2=(assign argl (op list) (reg val))
(assign val #0# (const n) . #1#)
#3=(assign argl (op cons) (reg val) (reg argl))
#4=(test (op primitive-procedure?) (reg proc))
(branch (label primitive-branch23))
compiled-branch24
(assign continue (label after-call25))
#5=(assign val (op compiled-procedure-entry) (reg proc))
#6=(goto (reg val))
primitive-branch23
(assign val . #7=((op apply-primitive-procedure) (reg proc) (reg argl)))
after-call25
(restore env)
(restore continue)
(test (op false?) (reg val))
(branch (label false-branch21))
true-branch20
(assign val (const 1))
#8=(goto (reg continue))
false-branch21
(assign proc #0# (const *) . #1#)
(save continue)
(save proc)
(assign val #0# (const n) . #1#)
#2#
(save argl)
(assign proc #0# (const factorial) . #1#)
(save proc)
(assign proc #0# (const -) . #1#)
(assign val (const 1))
#2#
(assign val #0# (const n) . #1#)
#3#
#4#
(branch (label primitive-branch26))
compiled-branch27
(assign continue (label after-call28))
#5#
#6#
primitive-branch26
(assign val . #7#)
after-call28
#2#
(restore proc)
#4#
(branch (label primitive-branch29))
compiled-branch30
(assign continue (label after-call31))
#5#
#6#
primitive-branch29
(assign val . #7#)
after-call31
(restore argl)
#3#
(restore proc)
(restore continue)
#4#
(branch (label primitive-branch32))
compiled-branch33
(assign val (op compiled-procedure-entry) (reg proc))
(goto (reg val))
primitive-branch32
(assign val . #7#)
#8#
after-call34
after-if22
after-lambda19
(perform (op define-variable!) (const factorial) (reg val) (reg env))
(assign val (const ok))
#8#))


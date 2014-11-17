;; 5.46
(load "./compile-and-go.scm")

(compile-and-go
 '(define (fib n)
    (if (< n 2)
        n
        (+ (fib (- n 1)) (fib (- n 2))))))

;;; EC-Eval input:
(fib 12)
(total-pushes = 2327 maximum-depth = 35)

;; Fibonacci 特化マシン
(define fib-machine
  (make-machine
   '(continue n val)
   (list
    (list 'null? null?)
    (list 'cons cons)
    (list 'car car)
    (list 'cdr cdr)
    (list '< <)
    (list '- -)
    (list '+ +)
    )
   '(
     (assign continue (label fib-done))
   fib-loop
     (test (op <) (reg n) (const 2))
     (branch (label immediate-answer))
     ;; Fib(n-1)を計算するよう設定
     (save continue)
     (assign continue (label afterfib-n-1))
     (save n)                           ; nの昔の値を退避
     (assign n (op -) (reg n) (const 1)); nを n-1 に変える
     (goto (label fib-loop))            ; 再帰呼出しを実行
   afterfib-n-1                         ; 戻った時 Fib(n-1)はvalにある
     (restore n)
     (restore continue)
     ;; Fib(n-2)を計算するよう設定
     (assign n (op -) (reg n) (const 2))
     (save continue)
     (assign continue (label afterfib-n-2))
     (save val)                         ; Fib(n-1)を退避
     (goto (label fib-loop))
   afterfib-n-2                         ; 戻った時Fib(n-2)の値はvalにある
     (assign n (reg val))               ; nにはFib(n-2)がある
     (restore val)                      ; valにはFib(n-1)がある
     (restore continue)
     (assign val                        ; Fib(n-1)+Fib(n-2)
     (op +) (reg val) (reg n))
     (goto (reg continue))              ; 呼出し側に戻る. 答えはvalにある
   immediate-answer
     (assign val (reg n))               ; 基底の場合: Fib(n)=n
     (goto (reg continue))
   fib-done
     (perform (op print-stack-statistics))  
     )))

(set-register-contents! fib-machine 'val 0)
(set-register-contents! fib-machine 'n 30)
(start fib-machine)
(print "(fib) val =>" (get-register-contents fib-machine 'val))
(fib-machine 'print-statistics)

;;; (fib 12) : (total-pushes = 928 maximum-depth = 22)

Fibonacci 特化マシンの方が使用する total-pushes と maximum-depth の n に伴う増加が少ない。
特定の演算に特化したマシンは速いよねという話？

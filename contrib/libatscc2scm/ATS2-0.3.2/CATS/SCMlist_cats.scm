;;;;;;
;
; HX-2016-06:
; for Scheme code translated from ATS
;
;;;;;;

;;;;;;
; beg of [SCMlist_cats.scm]
;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(define-macro
 (ats2scmpre_SCMlist_nil) `(list))
(define-macro
 (ats2scmpre_SCMlist_sing x) `(list ,x))
(define-macro
 (ats2scmpre_SCMlist_pair x1 x2) `(list ,x1 ,x2))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-macro
 (ats2scmpre_SCMlist_cons x0 xs) `(cons ,x0 ,xs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; (define
;;  (ats2scmpre_SCMlist_make_elt n x0)
;;  (letrec
;;    ((loop
;;      (lambda(n res)
;;       (if (> n 0) (loop (- n 1) (ats2scmpre_SCMlist_cons x0 res)) res))
;;     )
;;    ) (loop n (ats2scmpre_SCMlist_nil))
;;  ) ;; letrec
;; ) ;; define-ats2scmpre_SCMlist_make_elt
(define-macro
 (ats2scmpre_SCMlist_make_elt n x0) `(make-list ,n ,x0))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-macro
 (ats2scmpre_SCMlist_is_nil xs) `(null? ,xs))
(define-macro
 (ats2scmpre_SCMlist_is_cons xs) `(not (null? ,xs)))
(define-macro
 (ats2scmpre_SCMlist_isnot_nil xs) `(not (null? ,xs)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(define-macro
 (ats2scmpre_SCMlist_length xs) `(length ,xs))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define-macro (ats2scmpre_SCMlist_head xs) `(car ,xs))
(define-macro (ats2scmpre_SCMlist_tail xs) `(cdr ,xs))
(define-macro (ats2scmpre_SCMlist_last_pair xs) `(last-pair ,xs))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(define-macro
 (ats2scmpre_SCMlist_get_at xs i) `(list-ref ,xs ,i))
(define-macro
 (ats2scmpre_SCMlist_set_at xs i x0) `(list-set! ,xs ,i ,x0))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
(define-macro
 (ats2scmpre_SCMlist_append xs ys) `(append ,xs ,ys))
;;
(define-macro (ats2scmpre_SCMlist_reverse xs) `(reverse ,xs))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;; end of [SCMlist_cats.scm] ;;;;;;

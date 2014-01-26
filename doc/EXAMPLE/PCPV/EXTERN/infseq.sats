(* ****** ****** *)
//
// HX-2014-01-25
// [infseq]: infinte sequence of stamps
//
(* ****** ****** *)

sortdef stamp = int

(* ****** ****** *)

datasort infseq = (* abstract *)

(* ****** ****** *)

stacst infseq_nil : () -> infseq
stacst infseq_sing : (stamp) -> infseq
stacst infseq_cons : (stamp, infseq) -> infseq
stacst infseq_head : infseq -> stamp
stacst infseq_tail : infseq -> infseq

(* ****** ****** *)

stadef nil = infseq_nil
stadef cons = infseq_cons
stadef tail = infseq_tail
stadef head = infseq_head

(* ****** ****** *)
//
stacst infseq_get_at : (infseq, int) -> stamp
stacst infseq_set_at : (infseq, int, stamp) -> infseq
//
stadef select = infseq_get_at
stadef update = infseq_set_at
//
(* ****** ****** *)

stacst infseq_equaln
  : (infseq, infseq, int) -> bool
stadef equaln = infseq_equaln

(* ****** ****** *)
//
stacst infseq_take
  : (infseq, int(*n*)) -> infseq // take the first n elements
stacst infseq_drop
  : (infseq, int(*n*)) -> infseq // drop the first n elements
//
(* ****** ****** *)

stadef take = infseq_take
stadef drop = infseq_drop

(* ****** ****** *)
//
stacst
infseq_insert : (infseq, int, stamp) -> infseq
//
stacst infseq_remove : (infseq, int) -> infseq
//
(* ****** ****** *)

stadef insert = infseq_insert
stadef remove = infseq_remove

(* ****** ****** *)

stacst infseq_append : (infseq, int, infseq, int) -> infseq
stacst infseq_revapp : (infseq, int, infseq, int) -> infseq

(* ****** ****** *)

stadef append = infseq_append
stadef revapp = infseq_revapp

(* ****** ****** *)

stacst lt_stamp_infseq
  : (stamp, infseq, int(*n*)) -> bool // stamp < infseq[i] for i <= n
stacst lte_stamp_infseq
  : (stamp, infseq, int(*n*)) -> bool // stamp <= infseq[i] for i <= n

(* ****** ****** *)

stadef lt = lt_stamp_infseq; stadef lte = lt_stamp_infseq

(* ****** ****** *)

stacst lt_infseq_stamp
  : (infseq, int(*n*), stamp) -> bool // infseq[i] < stamp for i <= n
stacst lte_infseq_stamp
  : (infseq, int(*n*), stamp) -> bool // infseq[i] <= stamp for i <= n

(* ****** ****** *)

stadef lt = lt_infseq_stamp; stadef lte = lte_infseq_stamp

(* ****** ****** *)

stacst infseq_sorted : (infseq, int) -> bool // infseq[<n] is sorted
stadef sorted = infseq_sorted

(* ****** ****** *)

(* end of infseq.sats] *)

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
stacst infseq_get_at : (infseq, int) -> stamp // select
stacst infseq_set_at : (infseq, int, stamp) -> infseq // update
//
stadef select = infseq_get_at
stadef update = infseq_set_at
//
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

stacst infseq_equaln : (infseq, infseq, int) -> bool

(* ****** ****** *)

stadef equaln = infseq_equaln

(* ****** ****** *)

stacst infseq_append : (infseq, int, infseq, int) -> infseq
stacst infseq_revapp : (infseq, int, infseq, int) -> infseq

(* ****** ****** *)

stadef append = infseq_append
stadef revapp = infseq_revapp

(* ****** ****** *)

(* end of infseq.sats] *)

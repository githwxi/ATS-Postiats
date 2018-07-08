(*
** Basis for g-session types
*)

(* ****** ****** *)
//
staload "./basis_intset.sats"
staload "./basis_ssntype.sats"
//
(* ****** ****** *)
//
typedef
session_snd
  (a:vt@ype) = session_msg(0, 1, a)
typedef
session_rcv
  (a:vt@ype) = session_msg(1, 0, a)
//
stadef
snd = session_snd and rcv = session_rcv
//
vtypedef
chan1pos(ssn:type) = channel1(iset(0), 2, ssn)
vtypedef
chan1neg(ssn:type) = channel1(iset(1), 2, ssn)
//
(* ****** ****** *)
//
fun
{a:vt0p}
chan1pos_send{ssn:type}
  (!chan1pos(snd(a)::ssn) >> chan1pos(ssn), a): void
//
fun
{a:vt0p}
chan1pos_recv{ssn:type}
(
  !chan1pos(rcv(a)::ssn) >> chan1pos(ssn), &a? >> a
) : void // end-of-function
fun
{a:vt0p}
chan1pos_recv_val{ssn:type}
  (chp: !chan1pos(rcv(a)::ssn) >> chan1pos(ssn)): (a)
//
(* ****** ****** *)
//
fun
{a:vt0p}
chan1neg_recv{ssn:type}
  (!chan1neg(rcv(a)::ssn) >> chan1neg(ssn), a): void
//
fun
{a:vt0p}
chan1neg_send{ssn:type}
(
  !chan1neg(snd(a)::ssn) >> chan1neg(ssn), &a? >> a
) : void // end-of-function
fun
{a:vt0p}
chan1neg_send_val{ssn:type}
  (chn: !chan1neg(snd(a)::ssn) >> chan1neg(ssn)): (a)
//
(* ****** ****** *)
//
fun{}
chan1posneg_elim{ssn:type}(chan1pos(ssn), chan1neg(ssn)): void
//
(* ****** ****** *)
//
fun{}
chan1neg_create_exn
  {ssn:type}(fserv: chan1pos(ssn) -<lincloptr1> void): chan1neg(ssn)
//
fun{}
chan1pos_create_exn
  {ssn:type}(fserv: chan1neg(ssn) -<lincloptr1> void): chan1pos(ssn)
//
(* ****** ****** *)
//
typedef
session_list
  (a:vt@ype) =
  repeat(0, cons(msg(0, 1, a), nil))
typedef
session_colist
  (a:vt@ype) =
  repeat(1, cons(msg(0, 1, a), nil))
//
(* ****** ****** *)

(* end of [basis_ssntype2r.sats] *)

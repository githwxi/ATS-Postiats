(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
staload
"prelude/codegen.sats"
//
(* ****** ****** *)

abst0ype T0
absvt0ype VT0

(* ****** ****** *)

typedef
myrec_t =
$rec{
//
a= get(T0)
,
a= set(T0)
,
b= getset(double)
,
c= exch(VT0)
,
d= getref(VT0)
//
} (* end of [typedef] *)
//
(* ****** ****** *)

#codegen2(absrec, myrec_t)

(* ****** ****** *)

(*
//
extern
fun{}
myrec_get_a: myrec_t -<> int
overload .a with myrec_get_a
extern
fun{}
myrec_set_a: (myrec_t, int) -<!wrt> void
overload .a with myrec_set_a
//
extern
fun{}
myrec_get_b: myrec_t -<> double
overload .b with myrec_get_b
extern
fun{}
myrec_set_b: (myrec_t, double) -<!wrt> void
overload .b with myrec_set_b
//
extern
fun{}
myrec_exch_c: (myrec_t, VT0) -<!wrt> VT0
extern
fun{}
myrec_getref_d: (myrec_t) -<> vtakeoutptr(VT0)
//
*)

(* ****** ****** *)

(* end of [absrec.sats] *)

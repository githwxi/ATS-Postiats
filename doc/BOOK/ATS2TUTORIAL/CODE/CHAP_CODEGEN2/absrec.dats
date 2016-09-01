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

vtypedef
myarr_t
(
  a:vt0p
, l:addr, n:int
) = @{
//
a= get(int(n))
,
b= getref(array(a, n))
//
,
_ignored_ = unit_v(*void*)
//
} // end of [myarr_t]

(* ****** ****** *)
//
(*
vtypedef
myrec_t
(
  l: addr
) = $rec_vt{
//
a= get(T0)
,
a= set(T0)
,
b= getset(T0)
,
c= exch($tup(int, VT0))
,
d= getref(VT0)
//
} (* end of [vtypedef] *)
*)
//
(* ****** ****** *)

#codegen2(absrec, myarr_t, myarr$)
// #codegen2(absrec, myrec_t, myrec$)

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

(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
typedef
myrec_t = $rec{
//
a= getset(int),
b= getref(@(int, string))
//
} (* end of [typedef] *)
//
(* ****** ****** *)

#codegen2(absrec, myrec_t, myrec)

(* ****** ****** *)

(*
//
extern
fun{}
myrec_get_a: myrec_t -<> int
extern
fun{}
myrec_set_a: (myrec_t, int) -<!wrt> void
//
extern
fun{}
myrec_getref_b: (myrec_t) -> vtakeoutptr(@(int, string))
//
*)

(* ****** ****** *)

(* end of [absrec.sats] *)

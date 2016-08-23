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
overload .a with myrec_get_a
extern
fun{}
myrec_set_a: (myrec_t, int) -<!wrt> void
overload .a with myrec_set_a
//
extern
fun{}
myrec_getref_b: (myrec_t) -<> vtakeoutptr(@(int, string))
overload .b with myrec_getref_b
//
*)

(* ****** ****** *)

(* end of [absrec.sats] *)

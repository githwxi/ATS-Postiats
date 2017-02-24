(*
** libatscc-common
*)

(* ****** ****** *)

(*
staload "./../basics.sats"
*)

(* ****** ****** *)
//
abstype gvlist_type
abstype gvarray_type
abstype gvhashtbl_type
//
typedef gvlist = gvlist_type
typedef gvarray = gvarray_type
typedef gvhashtbl = gvhashtbl_type
//
(* ****** ****** *)
//
fun gvarray_make_nil(intGte(0)): gvarray = "mac#%"
//
fun gvhashtbl_make_nil((*void*)): gvhashtbl = "mac#%"
//
(* ****** ****** *)

(* end of [gvalue.sats] *)

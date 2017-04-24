(* ****** ****** *)
(*
** HX-2017-04-22:
** For evaluating MYATSCCDEF
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
#include
"share/HATS\
/atspre_staload_libats_ML.hats"
//
(* ****** ****** *)
//
#staload UN = $UNSAFE
//
(* ****** ****** *)
//
#staload "./myatscc.sats"
//
(* ****** ****** *)

implement
myexpseq_stringize
  (xs) = res where
{
//
val ss =
list_map_fun<myexp><string>
  (xs, myexp_stringize)
//
val res = let
  val ss = $UN.list_vt2t(ss)
in
  stringlst_concat(g0ofg1(ss))
end // end of [val]
//
val ((*freed*)) = list_vt_free(ss)
//
} (* end of [myexpseq_stringize] *)

(* ****** ****** *)

(* end of [myatscc_evaler.dats] *)

(*
** Some testing code for [json_ML]
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxi AT gmail DOT edu
** Time: July, 2013
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/json.sats"
staload "./../SATS/json_ML.sats"

(* ****** ****** *)

staload _(*anon*) = "./../DATS/json.dats"
staload _(*anon*) = "./../DATS/json_ML.dats"

(* ****** ****** *)

fun
json_object2val0_list
(
  xs: List_vt (json_object0)
) : List0_vt (jsonVal) = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val v =
      json_object2val0 (x)
    val vs =
      json_object2val0_list (xs)
  in
    list_vt_cons{jsonVal} (v, vs)
  end // end of [list_vt_cons]
| ~list_vt_nil () => list_vt_nil ()
//
end // end of [json_object2val0_list]

(* ****** ****** *)

val () =
{
//
val x = jsonVal_ofstring "1"
val () = fprintln! (stdout_ref, "x = ", x)
//
val x = jsonVal_ofstring "1.0"
val () = fprintln! (stdout_ref, "x = ", x)
//
val x = jsonVal_ofstring "'foo'"
val () = fprintln! (stdout_ref, "x = ", x)
//
val x = jsonVal_ofstring "[1, 2, 3]"
val () = fprintln! (stdout_ref, "x = ", x)
//
val x = jsonVal_ofstring "{'a':1, 'b':2, 'c':3}"
val () = fprintln! (stdout_ref, "x = ", x)
//
} (* end of [val] *)

(* ****** ****** *)

val () = {
//
val out = stdout_ref
//
val xs =
json_tokener_parse_list ("\
{'relation':'self', 'name':'Hongwei'}\n\
{'relation':'wife', 'name':'Jinning'}\n\
{'relation':'daughter', 'name':'Zoe'}\n\
{'relation':'daughter', 'name':'Chloe'}\n\
")
//
val vs = json_object2val0_list (xs)
//
val (
) = fprint_list_vt_sep<jsonVal> (out, vs, "\n")
val () = list_vt_free (vs)
val () = fprint_newline (out)
//
} // end of [val]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [test06.dats] *)

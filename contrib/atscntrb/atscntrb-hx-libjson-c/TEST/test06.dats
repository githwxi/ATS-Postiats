(* ****** ****** *)
(*
** Testing code for [json]
*)
(* ****** ****** *)

(*
** Author: Hongwei Xi
** Start Time: July, 2013
** Authoremail: gmhwxiATgmailDOTedu
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
staload _(*anon*) = "./../DATS/json.dats"

(* ****** ****** *)

fun
json_objlst_fprint_and_free
(
  out: FILEref, xs: List_vt (json_object0), i: int
) : void = let
in
//
case+ xs of
| ~list_vt_cons
    (x, xs) => let
    val () = fprint! (out, "jobj(", i, ") = ", x)
    val () = fprint_newline (out)
    val _freed = json_object_put (x)
  in
    json_objlst_fprint_and_free (out, xs, i+1)
  end // end of [list_vt_cons]
| ~list_vt_nil () => ()
//
end // end of [json_objlst_fprint_and_free]

(* ****** ****** *)

implement
main0((*void*)) =
{
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
val () = json_objlst_fprint_and_free (out, xs, 0)
//
} // end of [main0]

(* ****** ****** *)

(* end of [test06.dats] *)

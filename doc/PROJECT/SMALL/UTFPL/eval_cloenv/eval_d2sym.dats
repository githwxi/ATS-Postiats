(*
** Implementing UTFPL
** with closure-based evaluation
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
staload
"./../utfpl.sats"
//
staload "./eval.sats"
//
(* ****** ****** *)

implement
eval_d2sym
  (env, d2s) = let
  val opt = the_d2symmap_find (d2s)
in
  case+ opt of
  | ~Some_vt (def) => def | ~None_vt () => VALsym (d2s)
end // end of [eval_d2sym]

(* ****** ****** *)

local
//
staload "libats/ML/SATS/hashtblref.sats"
//
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
//
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
val mymap = hashtbl_make_nil<string,value>(i2sz(1024))
//
in (* in of [local] *)

fun
the_d2symmap_add_name
(
  name: string, def: value
) : void =
(
  hashtbl_insert_any (mymap, name, def)
)

implement
the_d2symmap_add
  (d2s, def) = let
//
val sym = d2s.name
//
in
//
the_d2symmap_add_name (sym.name, def)
//
end // end of [the_d2symmap_add]

(* ****** ****** *)

implement
the_d2symmap_find
  (d2s) = let
//
val sym = d2s.name
//
in
  hashtbl_search (mymap, sym.name)
end // end of [the_d2symmap_add]

end // end of [local]

(* ****** ****** *)

local

fun mfn_add
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1+i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat (d1+d2)
| (VALstring (s1), VALstring (s2)) => VALstring (strptr2string(string_append(s1,s2)))
| (_, _) => VALerror ()
//
end // end of [mfn_add]

(* ****** ****** *)

fun mfn_sub
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1-i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat (d1-d2)
| (_, _) => VALerror ()
//
end // end of [mfn_sub]

(* ****** ****** *)

fun mfn_mul
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1*i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat (d1*d2)
| (_, _) => VALerror ()
//
end // end of [mfn_mul]

(* ****** ****** *)

fun mfn_div
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALint (i1/i2)
| (VALfloat (d1), VALfloat (d2)) => VALfloat (d1/d2)
| (_, _) => VALerror ()
//
end // end of [mfn_div]

(* ****** ****** *)

fun mfn_less
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALbool (i1 < i2)
| (VALfloat (d1), VALfloat (d2)) => VALbool (d1 < d2)
| (VALstring (s1), VALstring (s2)) => VALbool (s1 < s2)
| (_, _) => VALerror ()
//
end // end of [mfn_less]

(* ****** ****** *)

fun mfn_lesseq
(
  vs: valuelst
) : value = let
//
val-list_cons (v1, vs) = vs
val-list_cons (v2, vs) = vs
//
in
//
case+ (v1, v2) of
| (VALint (i1), VALint (i2)) => VALbool (i1 <= i2)
| (VALfloat (d1), VALfloat (d2)) => VALbool (d1 <= d2)
| (VALstring (s1), VALstring (s2)) => VALbool (s1 <= s2)
| (_, _) => VALerror ()
//
end // end of [mfn_lesseq]

(* ****** ****** *)

fun mfn_print
(
  vs: valuelst
) : value = let
//
fun loop
(
  vs: valuelst, i: int
) : void = let
in
//
case+ vs of
| list_nil () => ()
| list_cons
    (v, vs) => let
    val () = if i > 0 then print ", "
    val () = fprint_value (stdout_ref, v)
  in
    loop (vs, i+1)
  end // end of [list_cons]
//
end // end of [loop]
//
val ((*void*)) = loop (vs, 0)
//
in
  VALvoid ((*void*))
end // end of [mfn_print]

in (* in of [local] *)
//
val () = the_d2symmap_add_name ("+", VALfun(mfn_add))
val () = the_d2symmap_add_name ("-", VALfun(mfn_sub))
val () = the_d2symmap_add_name ("*", VALfun(mfn_mul))
val () = the_d2symmap_add_name ("/", VALfun(mfn_div))
//
val () = the_d2symmap_add_name ("<", VALfun(mfn_less))
val () = the_d2symmap_add_name ("<=", VALfun(mfn_lesseq))
//
val () = the_d2symmap_add_name ("print", VALfun(mfn_print))
//
end // end of [local]

(* ****** ****** *)

(* end of [eval_d2sym.dats] *)

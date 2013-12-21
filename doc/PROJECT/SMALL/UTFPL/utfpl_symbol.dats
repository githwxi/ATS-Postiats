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
staload "libats/ML/SATS/hashtblref.sats"
//
staload _(*anon*) = "libats/DATS/hashfun.dats"
staload _(*anon*) = "libats/DATS/linmap_list.dats"
staload _(*anon*) = "libats/DATS/hashtbl_chain.dats"
//
staload _(*anon*) = "libats/ML/DATS/hashtblref.dats"
//
(* ****** ****** *)

staload "./utfpl.sats"

(* ****** ****** *)

datatype symbol = SYM of (string, int)

(* ****** ****** *)

assume symbol_type = symbol

(* ****** ****** *)

local

val count = ref<int> (0)
val mymap = hashtbl_make_nil<string,symbol>(i2sz(1024))

in (* in of [local] *)

implement
symbol_make (name) = let
//
val opt = hashtbl_search (mymap, name)
//
in
//
case+ opt of
| ~Some_vt (sym) => sym
| ~None_vt ((*void*)) => let
    val n = !count
    val () = !count := n + 1
    val sym = SYM (name, n)
//
    val () = hashtbl_insert_any (mymap, name, sym)
//
  in
    sym
  end // end of [None_vt]
//
end // end of [symbol_make]

end // end of [local]

(* ****** ****** *)
//
implement
symbol_get_name (sym) =
  let val+SYM (name, _) = sym in name end
//
(* ****** ****** *)

implement
fprint_symbol
  (out, sym) = let
//
val+SYM (name, _) = sym
//
in
  fprint_string (out, name)
end // end of [fprint_symbol]

(* ****** ****** *)

implement
compare_symbol_symbol
  (sym1, sym2) = let
//
val+SYM (_, n1) = sym1
val+SYM (_, n2) = sym2
//
in
  compare (n1, n2)
end // end of [compare_symbol_symbol]

(* ****** ****** *)

(* end of [utfpl_symbol.dats] *)

(*
** FALCON project
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
  
staload "./falcon.sats"
  
(* ****** ****** *)
//
staload "libats/ML/SATS/hashtblref.sats"
//
staload _ = "libats/DATS/hashfun.dats"
staload _ = "libats/DATS/linmap_list.dats"
staload _ = "libats/DATS/hashtbl_chain.dats"
//
staload _ = "libats/ML/DATS/hashtblref.dats"
//
(* ****** ****** *)
//
datatype
symbol =
SYMBOL of (string, int)
//
assume symbol_type = symbol
//
(* ****** ****** *)
//
implement
print_symbol (sym) =
  fprint_symbol (stdout_ref, sym)
//
implement
fprint_symbol
  (out, SYMBOL(name, n)) =
  fprint! (out, name, "(", n, ")")
//
(* ****** ****** *)

implement
symbol_get_name (SYMBOL(name, _)) = name
implement
symbol_get_stamp (SYMBOL(_, stamp)) = stamp

(* ****** ****** *)
//
implement
symbol_equal
  (x1, x2) = (
  $UNSAFE.cast{ptr}(x1) = $UNSAFE.cast{ptr}(x2)
) (* end of [symbol_equal] *)
//
implement
symbol_compare
  (SYMBOL(_, n1), SYMBOL(_, n2)) = compare (n1, n2)
// end of [symbol_compare]
//
(* ****** ****** *)

local
//
typedef key = string and itm = symbol
//
val N = ref<int> (0)
val HT =
  hashtbl_make_nil<key,itm> (i2sz(1024))
// end of [val]
//
in (* in-of-local *)

implement
the_symtbl_count () = !N

implement
symbol_make (name) = let
  val opt = hashtbl_search (HT, name)
in
//
case+ opt of
| ~Some_vt (sym) => sym
| ~None_vt ((*void*)) => let
    val n = !N
    val () = !N := succ(n)
    val sym = SYMBOL (name, n)
    val () = hashtbl_insert_any (HT, name, sym)
  in
    sym
  end (* end of [None_vt] *)
//
end // end of [symbol_make]

end // end of [local]

(* ****** ****** *)

(* end of [falcon_symbol.dats] *)

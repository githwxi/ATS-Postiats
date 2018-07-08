(*
** For ATS2TUTORIAL
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

abstype symbol = ptr

(* ****** ****** *)
//
extern
fun symbol_eq (symbol, symbol): bool
extern
fun symbol_neq (symbol, symbol): bool
//
extern
fun fprint_symbol : fprint_type(symbol)  
//
(* ****** ****** *)

overload = with symbol_eq
overload != with symbol_neq
overload fprint with fprint_symbol

(* ****** ****** *)

implement
fprint_val<symbol> = fprint_symbol

(* ****** ****** *)

extern
fun symbol_make_name(string): symbol

(* ****** ****** *)

local

typedef
key = string and itm = symbol

in (* in-of-local *)

#include "libats/ML/HATS/myhashtblref.hats"

end // end of [local]

(* ****** ****** *)

local
//
datatype
symbol_ =
SYMBOL of (string, int)
assume symbol = symbol_
//
val
theCount = ref<int> (0)
val
theSymtbl =
myhashtbl_make_nil(1024)
//
in (*in-of-local*)

(* ****** ****** *)
//
implement
symbol_eq
  (SYMBOL(_, n1), SYMBOL(_, n2)) = n1 = n2
implement
symbol_neq
  (SYMBOL(_, n1), SYMBOL(_, n2)) = n1 != n2
//
(* ****** ****** *)
//
implement
fprint_symbol
(
  out, SYMBOL(name, count)
) = fprint! (out, "SYMBOL(", name, ", ", count, ")")
//
(* ****** ****** *)

implement
symbol_make_name
  (name) = let
//
val opt = theSymtbl.search(name)
//
in
  case+ opt of
  | ~Some_vt x => x
  | ~None_vt () => let
      val n = !theCount
      val () = !theCount := n + 1
      val x_new = SYMBOL(name, n)
      val-~None_vt() = theSymtbl.insert (name, x_new)
    in
      x_new
    end // end of [None_vt]
end // end of [symbol_make_name]

end // end of [local]

(* ****** ****** *)
//
val sym0 = symbol_make_name("potato")
val sym0 = symbol_make_name("potato")
//
val sym1 = symbol_make_name("tomato")
val sym1 = symbol_make_name("tomato")
//
val sym2 = symbol_make_name("cucumber")
val sym2 = symbol_make_name("cucumber")
//
val sym3 = symbol_make_name("zucchini")
val sym3 = symbol_make_name("zucchini")
//
(* ****** ****** *)

val out = stdout_ref
val ((*void*)) = fprintln! (out, "sym0 = ", sym0)
val ((*void*)) = fprintln! (out, "sym1 = ", sym1)
val ((*void*)) = fprintln! (out, "sym2 = ", sym2)
val ((*void*)) = fprintln! (out, "sym3 = ", sym3)

(* ****** ****** *)

implement main0 () = {}

(* ****** ****** *)

(* end of [chap_hashtable2.dats] *)

(*
** ATS-extsolve:
** For solving ATS-constraints
** with external SMT-solvers
*)

(* ****** ****** *)

(*
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
*)

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
symbol =
SYMBOL of (string, int)
//
assume symbol_type = symbol
//
val
theCount = ref<int> (0)
val
theSymtbl =
myhashtbl_make_nil(1024)
//
in (*in-of-local*)

implement
fprint_symbol
(
  out, sym
) = let
//
val+SYMBOL(name, cnt) = sym
//
in
  fprint! (out, name)
(*
  fprint! (out, "SYMBOL(", name, ", ", cnt, ")")
*)
end // end of [fprint_symbol]

(* ****** ****** *)
//
implement
symbol_get_name
  (sym) = name where { val+SYMBOL(name, _) = sym }
//
(* ****** ****** *)
  
implement
symbol_make_name
  (name) = let
//
val opt = theSymtbl.search(name)
//
in
//
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
//
end // end of [symbol_make_name]

(* ****** ****** *)

implement
eq_symbol_symbol
  (x1, x2) = let
//
val+SYMBOL(_, n1) = x1
val+SYMBOL(_, n2) = x2
//
in
  n1 = n2
end // end of [eq_symbol_symbol]

(* ****** ****** *)

implement
neq_symbol_symbol
  (x1, x2) = let
//
val+SYMBOL(_, n1) = x1
val+SYMBOL(_, n2) = x2
//
in
  n1 != n2
end // end of [neq_symbol_symbol]

(* ****** ****** *)

implement
compare_symbol_symbol
  (x1, x2) = let
//
val+SYMBOL(_, n1) = x1
val+SYMBOL(_, n2) = x2
//
in
  g0int_compare (n1, n1)
end // end of [compare_symbol_symbol]

(* ****** ****** *)

end // end of [local]

(* ****** ****** *)

(* end of [patsolve_cnstrnt_symbol.dats] *)

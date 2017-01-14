(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload "./../SATS/catsparse.sats"

(* ****** ****** *)
//
datatype
symbol =
SYMBOL of (string(*name*), int(*stamp*))
//
(* ****** ****** *)

assume symbol_type = symbol

(* ****** ****** *)
//
implement
symbol_get_name (sym) =
  let val+SYMBOL (name, _) = sym in name end
//
(* ****** ****** *)

implement
eq_symbol_symbol
  (x1, x2) = let
  val+SYMBOL (_, n1) = x1
  val+SYMBOL (_, n2) = x2
in
  if n1 = n2 then true else false
end // end of [eq_symbol_symbol]

(* ****** ****** *)

local

staload SYMCNT =
{
//
#include
"share/atspre_define.hats"
//
#staload _(*anon*) =
"prelude/DATS/integer.dats"
//
#include
"{$HX_GLOBALS}/HATS/gcount.hats"
//
} (* end of [staload] *)

(* ****** ****** *)

staload SYMBOL =
{
//
#include
"share/atspre_define.hats"
//
#staload "./../SATS/catsparse.sats"
//
typedef key = string
typedef itm = symbol
//
#define CAPACITY 4096
//
#staload
"libats/SATS/hashtbl_linprb.sats"
//
implement
hashtbl$recapacitize<> ((*void*)) = 1
//
#include
"{$HX_GLOBALS}/HATS/ghashtbl_linprb.hats"
//
} (* end of [staload] *)

in (* in-of-local *)

implement
symbol_make(name) = let
//
val cp = $SYMBOL.search_ref (name)
//
in
//
if isneqz(cp)
  then $UNSAFE.cptr_get<symbol> (cp)
  else let
    val n = $SYMCNT.getinc ()
    val sym = SYMBOL (name, n)
    val-~None_vt() = $SYMBOL.insert_opt (name, sym)
  in
    sym
  end // end of [else]
//
end // end of [symbol_make]

end // end of [local]

(* ****** ****** *)

implement
fprint_symbol
  (out, x) = let
  val+SYMBOL (name, n) = x in fprint! (out, name, "(", n, ")")
end // end of [fprint_symbol]

(* ****** ****** *)

(* end of [catsparse_symbol.dats] *)

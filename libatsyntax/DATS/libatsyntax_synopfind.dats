(*
**
** Some utility functions
** for manipulating the syntax of ATS2
**
** Contributed by Hongwei Xi (gmhwxi AT gmail DOT com)
**
** Start Time: June, 2012
**
*)

(* ****** ****** *)
//
// Finding the declaration of a given declname
//
(* ****** ****** *)
//
staload "libatsyntax/SATS/libatsyntax.sats"
staload "libatsyntax/DATS/libatsyntax_psynmark.dats"
staload "libatsyntax/DATS/libatsyntax_pats2xhtml.dats"
//
(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)

local

implement
psynmark_process<> (psm, putc) =
  psynmark_process_xhtml_bground (psm, putc)
// end of [psynmark_process<>]

fun auxfind (
  xs: declreplst, sym: symbol
) : Option_vt (charlst) = let
in
//
case+ xs of
| list_cons (x, xs) =>
    if test_symbol_d0ecl (sym, x.0)
      then Some_vt (x.1) else auxfind (xs, sym)
    // end of [if]
| list_nil () => None_vt ()
//
end // end of [auxfind]

in // in of [local]

implement
declreplst_find_synopsis
  (xs, sym) = let
  val opt = auxfind (xs, sym)
in
//
case+ opt of
| ~Some_vt (synop) => 
    charlst_pats2xhtmlize<> (0(*sta*), synop)
  // end of [Some_Vt]
| ~None_vt () => let
    val name = $SYM.symbol_get_name (sym)
  in
    sprintf ("Synopsis for [%s] is unavailable.", @(name))
  end // end of [None_vt]
//
end // end of [declreplst_find_synopsis]

end // end of [local]

(* ****** ****** *)

(* end of [libatsyntax_synopfind.dats] *)

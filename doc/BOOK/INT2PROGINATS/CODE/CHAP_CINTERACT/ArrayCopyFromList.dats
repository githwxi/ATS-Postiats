(*
** Some code used in the book INT2PROGINATS
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

staload "libats/ML/SATS/basis.sats"
staload "libats/ML/SATS/list0.sats"
staload "libats/ML/SATS/array0.sats"

(* ****** ****** *)

extern
fun{a:t@ype}
array_copy_from_list (A: array0(a), xs: list0(a)): void

(* ****** ****** *)

implement{a}
array_copy_from_list (A, xs) = let
//
fun loop
(
  p: ptr, xs: list0 (a)
) : void =
(
case+ xs of
| list0_nil () => ()
| list0_cons (x, xs) => let
    val () = $UN.ptr0_set<a> (p, x) in loop (ptr0_succ<a> (p), xs)
  end // end of [list0_cons]
) (* end of [loop] *)
//
in
  loop (array0_get_ref(A), xs)
end // end of [array_copy_from_list]

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [ArrayCopyFromList.dats] *)

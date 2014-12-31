(*
** A test for atspkgreloc
*)
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define
ATS_PACKNAME "atspkgreloc_test01"

(* ****** ****** *)

staload
GCOUNT1 = {
//
#include "{http://ats-lang.sourceforge.net/LIBRARY/contrib}/libats-/hwxi/globals/HATS/gcount.hats"
//
} (* end of [GCOUNT1] *)

(* ****** ****** *)

staload
GCOUNT2 = {
//
#include "{http://ats-lang.sourceforge.net/LIBRARY/contrib}/libats-/hwxi/globals/HATS/gcount.hats"
//
} (* end of [GCOUNT2] *)

(* ****** ****** *)

implement
main0 () = () where
{
//
val () = println! ("$GCOUNT1.getinc() = ", $GCOUNT1.getinc())
val () = println! ("$GCOUNT1.getinc() = ", $GCOUNT1.getinc())
val () = println! ("$GCOUNT1.getinc() = ", $GCOUNT1.getinc())
//
val () = println! ("$GCOUNT2.getinc() = ", $GCOUNT2.getinc())
val () = println! ("$GCOUNT2.getinc() = ", $GCOUNT2.getinc())
val () = println! ("$GCOUNT2.getinc() = ", $GCOUNT2.getinc())
//
} (* end of [main0] *)

(* ****** ****** *)

(* end of [test01.dats] *)

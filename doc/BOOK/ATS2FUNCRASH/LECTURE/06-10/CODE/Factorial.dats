(* ****** ****** *)
(*
** Factorial
*)
(* ****** ****** *)
(*
##myatsccdef=\
patsopt -d $1 | atscc2php -o $fname($1)_dats.php -i -
*)
(* ****** ****** *)
//
#define ATS_DYNLOADFLAG 0
//
#define
ATS_EXTERN_PREFIX "Factorial_"
#define
ATS_STATIC_PREFIX "_Factorial_"
//
(* ****** ****** *)
//
// HX: for accessing LIBATSCC2PHP 
//
#define
LIBATSCC2PHP_targetloc
"$PATSHOME/contrib\
/libatscc2php/ATS2-0.3.2" // latest stable release
//
#include
"{$LIBATSCC2PHP}/staloadall.hats" // for prelude stuff
//
(* ****** ****** *)
//
extern
fun
Factorial(n: int): int = "mac#%"
//
(* ****** ****** *)
//
implement
Factorial(n) =
(fix
 loop(i: int, res: int) =<cloref1>
 if i < n then loop(i+1, res*(i+1)) else res
)(0, 1) // end of [Factorial]
//
(* ****** ****** *)

(* end of [Factorial.dats] *)

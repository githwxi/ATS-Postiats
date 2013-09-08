(*
**
** random password generation
**
** Author: Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** Time: August, 2008
**
*)

(* ****** ****** *)
//
// HX: Happy Thanksgiving!
// HX: ported to Postiats on November 22, 2012
//
(* ****** ****** *)
//
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
//
(* ****** ****** *)

staload UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload STDLIB = "libc/SATS/stdlib.sats"
staload RANDGEN = "{$LIBATSHWXI}/testing/SATS/randgen.sats"

(* ****** ****** *)

implement{a}
arrayref_make_elt
  {n} (asz, x0) = let
//
val (pf, pfgc | p0) = array_ptr_alloc<a> (asz)
//
var i: size_t
var p: ptr = p0
val () = $effmask_ntm
(
//
for
(
  i := i2sz(0); i < asz; i := succ(i)
) (
  $UN.ptr0_set<a> (p, x0); p := ptr_succ<a>(p)
) // end of [for]
//
) // end of [val]
//
in
  $UN.castvwtp0{arrayref(a,n)}((pf, pfgc | p0))
end // end of [arrayref_make_elt]

(* ****** ****** *)

implement(a:t0p)
fprint_arrayref_sep<a>
  {n} (out, A, asz, sep) = let
//
fun loop
  (i: sizeLte(n)): void =
(
  if i < asz then
  (
    if i > 0 then fprint_string (out, sep);
    fprint_val<a> (out, A[i]); loop (succ(i))
  ) else () // end of [if]
) (* end of [loop] *)
//
prval () = lemma_arrayref_param (A)
//
in
  loop (i2sz(0))
end // end of [fprint_arrayref_sep]

(* ****** ****** *)

%{^
#include <time.h>
#include <stdlib.h>
atsvoid_t0ype
srand_with_time ()
{
  srand(time(0)) ; return ;
}
%}
extern fun srand_with_time (): void = "ext#"

(* ****** ****** *)

(*
fun{} randint {n:pos} (n: int n): natLt (n)
*)
implement
$RANDGEN.randint<> {n} (n) = $UN.cast{natLt(n)}($STDLIB.rand() mod n)

(* ****** ****** *)

implement
main (
  argc, argv
) = 0 where {
  var n: int = 8
  val () =
    if argc >= 2 then n := $STDLIB.atoi (argv[1])
  // end of [val]
  val [n:int] n = g1ofg0_int (n)
  val () = assert (n >= 0)
  val () = srand_with_time ((*void*))
  val asz = g1int2uint (n)
  val passwd =
    arrayref_make_elt<char> (asz, '\000')
  val () =
    loop (passwd, n, 0) where
  {
    fun loop {i:nat | i <= n} .<n-i>.
    (
      passwd: arrayref (char, n), n: int n, i: int i
    ) : void =
      if (i < n) then let
        val () = passwd[i] := int2char0 ($RANDGEN.randint (94) + 33)
      in
        loop (passwd, n, i+1)
      end else () // end of [if]
  } // end of [where]
//
  val out = stdout_ref
  val () = fprint_arrayref_sep (out, passwd, asz, "")
  val () = fprint_newline (out)
//
} // end of [main]

(* ****** ****** *)

(* end of [passwdgen.dats] *)

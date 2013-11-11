(*
** The Great Computer Language Shootout
** http://shootout.alioth.debian.org/
**
** contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
** contributed by Zhiqiang Ren (aren AT cs DOT bu DOT edu)
**
** This code is nearly a direct translation from a C submission
** by Bonzini, Bartell and Mellor
**
** compilation command:
**   atscc -O3 -fomit-frame-pointer pidigits.dats -o pidigits -lgmp
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload "{$LIBGMP}/SATS/gmp.sats"

(* ****** ****** *)
//
var numer: mpz
viewdef
v_numer = mpz @ numer
val ((*void*)) =
  mpz_init_set_uint (numer, 1U)
//
var denom: mpz
viewdef
v_denom = mpz @ denom
val ((*void*)) =
  mpz_init_set_uint (denom, 1U)
//
var accum: mpz
viewdef
v_accum = mpz @ accum
val ((*void*)) =
  mpz_init_set_uint (accum, 0U)
//
var tmp1: mpz
viewdef v_tmp1 = mpz @ tmp1
val ((*void*)) = mpz_init (tmp1)
//
var tmp2: mpz
viewdef v_tmp2 = mpz @ tmp2
val ((*void*)) = mpz_init (tmp2)
//
(* ****** ****** *)
//
viewdef
v_all = @(v_numer, v_denom, v_accum, v_tmp1, v_tmp2)
//
prval pf_all = @(
  view@ numer, view@ denom, view@ accum, view@ tmp1, view@ tmp2
) (* end of [prval] *)
//
prval pfbox_all =
  vbox_make {v_all} (pf_all) where {
  extern praxi vbox_make {v:view} (pf: v): vbox (v)
} (* end of [prval] *)
//
(* ****** ****** *)

fn extract_digit
(
  pf_numer: !v_numer
, pf_denom: !v_denom
, pf_accum: !v_accum
, pf_tmp1: !v_tmp1, pf_tmp2: !v_tmp2
| (*none*)
) : int = let
  val sgn = mpz_cmp (numer, accum)
in
  case+ 0 of
  | _ when sgn > 0 => ~1
  | _ => let
      val () = mpz_mul_2exp (tmp1, numer, 1UL)
      val () = mpz_add (tmp1, numer)
      val () = mpz_add (tmp1, accum)
      val () = $extfcall (void, "mpz_fdiv_qr", addr@tmp1, addr@tmp2, addr@tmp1, addr@denom)
      val () = mpz_add (tmp2, numer)
    in
      if mpz_cmp (tmp2, denom) >= 0 then ~1 else mpz_get_int (tmp1)
    end // end of [_]
end // end of [extract_digit]

(* ****** ****** *)

fn next_term
(
  pf_numer: !v_numer
, pf_denom: !v_denom
, pf_accum: !v_accum
, pf_tmp1: !v_tmp1, pf_tmp2: !v_tmp2
| k: uint
) : void = let
  val y2 = 2U * k + 1U
  val () = mpz_mul_2exp (tmp1, numer, 1UL)
  val () = mpz_add (accum, tmp1)
  val () = mpz_mul (accum, y2)
  val () = mpz_mul (numer, k)
  val () = mpz_mul (denom, y2)
in
  // nothing
end // end of [next_term] 

(* ****** ****** *)

fn eliminate_digit
(
  pf_numer: !v_numer
, pf_denom: !v_denom
, pf_accum: !v_accum
| d: uint
) : void = () where
{
  val () = begin
    mpz_submul (accum, denom, d); mpz_mul (accum, 10); mpz_mul (numer, 10)
  end // end of [val]
} // end of [eliminate_digit]

(* ****** ****** *)

staload "libc/SATS/stdio.sats"

(* ****** ****** *)

fn pidigits
(
  pf_numer: !v_numer
, pf_denom: !v_denom
, pf_accum: !v_accum
, pf_tmp1: !v_tmp1, pf_tmp2: !v_tmp2
| n: int
) : void = () where
{
//
var d: int = ~1 // not needed at run-time
var i: int = 0 and k: uint = 0U and m: int?
//
val (
) = while (true) let
  val () = while (true) let
    val () = k := k+1U
    val () = next_term
      (pf_numer, pf_denom, pf_accum, pf_tmp1, pf_tmp2 | k)
    val () = d := extract_digit
      (pf_numer, pf_denom, pf_accum, pf_tmp1, pf_tmp2 | (*none*))
  in
    if d <> ~1 then $break
  end // end of [while]
  val _ = fputc (int2char0(0x30(*'0'*) + d), stdout_ref)
  val () = i := i+1
  val () = m := i mod 10
  val () = if (m = 0) then
  {
    val _ = $extfcall (int, "fprintf", stdout_ref, "\t:%d\n", i)
  }
  val () = if (i >= n) then $break
  val () = eliminate_digit (pf_numer, pf_denom, pf_accum | g0i2u(d))
//
in
  // nothing
end // end of [while]
//
} // end of [pidigits]

(* ****** ****** *)

implement
main0 (argc, argv) = let
  val n = (if argc > 1 then g0string2int (argv[1]) else 27): int
  prval vbox pf_all = pfbox_all
in
  $effmask_all (pidigits (pf_all.0, pf_all.1, pf_all.2, pf_all.3, pf_all.4 | n))
end // end of [main]

(* ****** ****** *)

(* end of [pidigits.dats] *)

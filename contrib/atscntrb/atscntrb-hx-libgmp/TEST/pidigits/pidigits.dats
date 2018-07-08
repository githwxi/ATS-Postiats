(*
** The Great Computer Language Shootout
** http://shootout.alioth.debian.org/
**
** contributed by Hongwei Xi (gmhwxiATgmailDOTcom)
*)

(* ****** ****** *)

(*
pidigits: pidigits.dats ; \
$(PATSCC) -I${PATSHOMERELOC}/contrib \
  -pipe -O3 -fomit-frame-pointer -march=native $< -o $@ -lgmp
*)

(* ****** ****** *)

#include
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
staload
"libats/libc/SATS/stdio.sats"
//
staload "./../../SATS/gmp.sats"
//
(* ****** ****** *)

local

var t1: mpz
val ((*void*)) = mpz_init (t1)
var t2: mpz
val ((*void*)) = mpz_init (t2)

in (* in-of-local *)

val p_t1 = addr@t1
val p_t2 = addr@t2

end // end of [local]

(* ****** ****** *)
  
local

var acc: mpz
val ((*void*)) = mpz_init_set(acc, 0u)
var num: mpz
val ((*void*)) = mpz_init_set(num, 1u)
var den: mpz
val ((*void*)) = mpz_init_set(den, 1u)

in (* in-of-local *)

val p_acc = addr@acc
val p_num = addr@num
val p_den = addr@den

end // end of [local]
  
(* ****** ****** *)

extern
fun
extract_digit (nth: uint): uint
implement
extract_digit
  (nth) = res where
{
//
  val (pf1, fpf1 | p_t1) = $UN.ptr0_vtake{mpz}(p_t1)
  val (pf2, fpf2 | p_t2) = $UN.ptr0_vtake{mpz}(p_t2)
  val (pf3, fpf3 | p_acc) = $UN.ptr0_vtake{mpz}(p_acc)
  val (pf4, fpf4 | p_num) = $UN.ptr0_vtake{mpz}(p_num)
  val (pf5, fpf5 | p_den) = $UN.ptr0_vtake{mpz}(p_den)
//
  val () = mpz_mul (!p_t1, !p_num, nth)
  val () = mpz_add (!p_t2, !p_t1, !p_acc)
  val () = mpz_tdiv_q (!p_t1, !p_t2, !p_den)
  val res = mpz_get_uint (!p_t1)
//
  prval () = fpf1 (pf1)
  prval () = fpf2 (pf2)
  prval () = fpf3 (pf3)
  prval () = fpf4 (pf4)
  prval () = fpf5 (pf5)
//
}

(* ****** ****** *)

extern
fun
eliminate_digit (d: uint): void
implement
eliminate_digit (d) =
{
//
  val (pf3, fpf3 | p_acc) = $UN.ptr0_vtake{mpz}(p_acc)
  val (pf4, fpf4 | p_num) = $UN.ptr0_vtake{mpz}(p_num)
  val (pf5, fpf5 | p_den) = $UN.ptr0_vtake{mpz}(p_den)
  val (pf32, fpf32 | p2_acc) = $UN.ptr0_vtake{mpz}(p_acc)
  val (pf42, fpf42 | p2_num) = $UN.ptr0_vtake{mpz}(p_num)
//
  val () = mpz_submul (!p_acc, !p_den, d)
  val () = mpz_mul (!p_acc, !p2_acc, 10)
  val () = mpz_mul (!p_num, !p2_num, 10)
//
  prval () = fpf3 (pf3)
  prval () = fpf4 (pf4)
  prval () = fpf5 (pf5)
  prval () = fpf32 (pf32)
  prval () = fpf42 (pf42)
//
}

(* ****** ****** *)

extern
fun
next_term (k: uint): void
implement
next_term (k) =
{
  val k2 = succ (2u * k)
//
  val (pf3, fpf3 | p_acc) = $UN.ptr0_vtake{mpz}(p_acc)
  val (pf32, fpf32 | p2_acc) = $UN.ptr0_vtake{mpz}(p_acc)
  val (pf4, fpf4 | p_num) = $UN.ptr0_vtake{mpz}(p_num)
  val (pf42, fpf42 | p2_num) = $UN.ptr0_vtake{mpz}(p_num)
  val (pf5, fpf5 | p_den) = $UN.ptr0_vtake{mpz}(p_den)
  val (pf52, fpf52 | p2_den) = $UN.ptr0_vtake{mpz}(p_den)
//
  val () = mpz_addmul (!p_acc, !p_num, 2u)
  val () = mpz_mul (!p_acc, !p2_acc, k2)
  val () = mpz_mul (!p_den, !p2_den, k2)
  val () = mpz_mul (!p_num, !p2_num, k)
//
  prval () = fpf3 (pf3)
  prval () = fpf4 (pf4)
  prval () = fpf5 (pf5)
  prval () = fpf32 (pf32)
  prval () = fpf42 (pf42)
  prval () = fpf52 (pf52)
//
}

(* ****** ****** *)

fun
compare_num_acc
  (): int = sgn where
{
  val (pf3, fpf3 | p_acc) = $UN.ptr0_vtake{mpz}(p_acc)
  val (pf4, fpf4 | p_num) = $UN.ptr0_vtake{mpz}(p_num)
  val sgn = mpz_cmp (!p_num, !p_acc)
  prval () = fpf3 (pf3)
  prval () = fpf4 (pf4)
} (* end of [compare_num_acc] *)

(* ****** ****** *)

fun
pidigits_loop
(
  n: uint
, i: uint, k: uint
) : void = let
in
//
if
i < n
then let
  val k = succ(k)
  val () = next_term (k)
  val sgn = compare_num_acc ()
in
  if sgn > 0
    then pidigits_loop (n, i, k)
    else let
      val d3 = extract_digit (3u)
      val d4 = extract_digit (4u)
    in
      if d3 != d4
        then pidigits_loop (n, i, k)
        else let
          val i = succ (i)
          val _ = putchar0 (char2int0('0') + g0u2i(d3))
          val () = if (i mod 10u = 0u) then $extfcall (void, "printf", "\t:%u\n", i)
          val () = eliminate_digit (d3)
        in
          pidigits_loop (n, i, k)
        end // end of [else]
    end // end of [else]
end // end of [then]
else () // end of [else]
//
end // end of [pidigits_loop]

(* ****** ****** *)

implement
main0 (argc, argv) = let
//
var n: int = 27
val () =
if argc >= 2 then (n := g0string2int (argv[1]))
val n2 = g1ofg0(n)
val () = assertloc (n2 >= 0)
//
in
  pidigits_loop (g0i2u(n2), 0u, 0u)
end // end of [main0]

(* ****** ****** *)

(* end of [pidigits.dats] *)

(*
** The Great Computer Language Shootout
** http://shootout.alioth.debian.org/
**
** contributed by Hongwei Xi (hwxi AT cs DOT bu DOT edu)
**
** compilation command:
**   patscc -O3 -msse2 -o mandelbrot mandelbrot.dats
*)

(* ****** ****** *)
//
// Ported to ATS2 by HX-2013-11-12
//
(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

#define TIMES 50
#define LIMIT2 (2.0 * 2.0)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

extern
fun mandelbrot (h: int, w: int): void

(* ****** ****** *)

macdef print_byte(i) = print($UN.cast{uchar}(,(i)))

(* ****** ****** *)

implement
mandelbrot (h, w) = let
//
val w_r = 1.0 / w and h_r = 1.0 / h
//
fun p
(
  x: int, y: int
) :<cloref1> bool = let
  val Cr = (2 * x) * w_r - 1.5
  and Ci = (2 * y) * h_r - 1.0
  fun lp
    (r: double, i: double, k: int):<cloref1> bool =
  let
    val r2 = r * r
    and i2 = i * i
  in
    if r2+i2 <= LIMIT2
      then (if k=0 then true else lp (r2-i2+Cr, 2.0*r*i+Ci, k-1))
      else false
    // end of [if]
  end
in
  lp (0.0, 0.0, TIMES)
end // end of [p]

fun xl
(
  x: int, y: int, b: int, n: natLte 8
) :<cloref1> void =
  if x < w then
  (
    if p (x, y)
      then
        if n > 0
          then xl (x+1, y, succ(b << 1), n-1)
          else (print_byte b; xl (x+1, y, 1, 7))
        // end of [if]
      else
        if n > 0
          then xl (x+1, y, b << 1, n-1)
          else (print_byte b; xl (x+1, y, 0, 7))
        // end of [if]
    // end of [if]
  ) else (
    print_byte (b << n);
    if (y < h-1) then xl (0, y+1, 0, 8)
  ) 
//
val _ = $extfcall (int, "printf", "P4\n%i %i\n", h, w)
//
in 
  if h > 0 then xl (0, 0, 0, 8)
end // end of [mandelbrot]

implement
main0 (argc, argv) = let
  val () = assertloc (argc >= 2)
  val i0 = g1ofg0(g0string2int(argv[1]))
  val () = assert_errmsg (i0 >= 2, "The input integer needs to be at least 2.\n")
in
  mandelbrot (i0, i0)
end (* end of [main0] *)

(* ****** ****** *)

(* end of [mandelbrot.dats] *)

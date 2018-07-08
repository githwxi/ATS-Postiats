(*
** Implementing Enigma
** based linear streams
*)

(* ****** ****** *)

#define N 26

(* ****** ****** *)

abst@ype x = int

(* ****** ****** *)

absvtype xs = stream_vt(x)

(* ****** ****** *)
//
extern
fun
f_rotorseq(xs: xs): xs
//
(* ****** ****** *)
//
extern
fun
f_plugboard(xs: xs): xs
//
extern
fun
f_reflector(xs: xs): xs
//
(* ****** ****** *)

extern
fun f_Enigma(xs: xs): xs

(* ****** ****** *)

abstype rotor

(* ****** ****** *)
//
datatype
rotorseq =
| rotorseq_sing of (rotor)
| rotorseq_cons of
  (rotor, natLt(N)(*notch*), rotorseq)
//
(* ****** ****** *)


(* ****** ****** *)

(*
x -> p^(R^(f(R(p(x)))))
*)

implement
f_Enigma(xs) =
f_plugboard(f_rotorseq(f_reflector(f_rotorseq(f_plugboard(xs)))))

(* ****** ****** *)

(* end of [Enigma.dats] *)

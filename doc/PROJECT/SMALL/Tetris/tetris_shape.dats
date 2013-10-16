(*
** Implementing Tetris
** This is a case study on
** combining ATS with Objective-C
*)

(* ****** ****** *)

(*
**
** Author: Chen GUO
** Authoremail: ...
** Author: Hongwei XI
** Authoremail: gmhwxiATgmailDOTcom
**
*)

(* ****** ****** *)

staload "./tetris.sats"

(* ****** ****** *)

assume
gmshape_type = '{
  X= int
, Y= int
, kind= int
, matrix= mtrxszref (int)
}

(* ****** ****** *)

(*

XXXX
XXXX
XXXX
XXXX

*)

(* ****** ****** *)

(*

XX
XX
XX
XX
XX
XX
XX
XX

*)

(* ****** ****** *)

(*

XX
XX
XXXX
XXXX
XX
XX

*)

(* ****** ****** *)

(*

XX
XX
XX
XX
XXXX
XXXX

*)

(* ****** ****** *)

(*

  XX
  XX
  XX
  XX
XXXX
XXXX

*)

(* ****** ****** *)

(*

  XX
  XX
XXXX
XXXX
XX
XX

*)

(* ****** ****** *)

(*

XX
XX
XXXX
XXXX
  XX
  XX

*)

(* ****** ****** *)

(* end of [tetris_shape.dats] *)

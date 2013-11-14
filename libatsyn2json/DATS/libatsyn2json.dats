(* ****** ****** *)
(*
**
** Some utility functions
** for turning ATS2 syntax trees into JSON format
**
*)
(* ****** ****** *)
(*
**
** Author: Hongwei Xi
** Authoremail: gmhwxiATgmailDOTcom
** Start Time: November, 2013
**
*)
(* ****** ****** *)

staload "src/pats_staexp2_util.sats"

(* ****** ****** *)

staload "./../SATS/libatsyn2json.sats"

(* ****** ****** *)

implement
s2exp_hnfize_flag_svar (s2e0, s2v, flag) = s2e0

(* ****** ****** *)

(* end of [libatsyn2json.dats] *)

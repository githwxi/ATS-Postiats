(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0 // HX: no dynloading

(* ****** ****** *)

extern
fun atsruntime_handle_uncaughtexn (exn): void = "ext#"
extern
fun atsruntime_handle_uncaughtexn_rest (exn): void = "ext#"

(* ****** ****** *)

implement
atsruntime_handle_uncaughtexn
  (exn) = let
//
macdef
errmsghead (
) = prerr ("exit(ATS): uncaught exception at run-time")
//
in
//
case+ exn of
//
| ~AssertExn () => let
    val () = errmsghead ()
    val () = prerrln! (": AssertExn") in exit(1)
  end // end of [AssertExn]  
| ~NotFoundExn () => let
    val () = errmsghead ()
    val () = prerrln! (": NotFoundExn") in exit(1)
  end // end of [AssertExn]  
| ~GenerallyExn (msg) => let
    val () = errmsghead ()
    val () = prerrln! (": GenerallyExn: ", msg) in exit(1)
  end // end of [GnerallyExn]
| ~IllegalArgExn (msg) => let
    val () = errmsghead ()
    val () = prerrln! (": IllegalArgExn: ", msg) in exit(1)
  end // end of [IllegalArgExn]
//
| _ => atsruntime_handle_uncaughtexn_rest (exn)
//
end // end of [atsruntime_handle_uncaughtexn]

(* ****** ****** *)

(* end of [pats_ccomp_runtime2.dats] *)

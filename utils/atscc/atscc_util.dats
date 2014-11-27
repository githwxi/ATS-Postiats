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

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: July, 2013 *)

(* ****** ****** *)

staload STDLIB = "libc/SATS/stdlib.sats"

(* ****** ****** *)

staload "./atscc.sats"

(* ****** ****** *)

macdef
unsome (opt) = stropt_unsome (,(opt))
macdef
issome (opt) = stropt_is_some (,(opt))

(* ****** ****** *)

#define
ATSOPT_DEFAULT "patsopt"

implement
{}(*tmp*)
atsopt_get () = let
//
val def =
  $STDLIB.getenv_gc ("PATSOPT")
//
in
//
if strptr2ptr (def) > 0
  then strptr2string (def)
  else let
    prval () = strptr_free_null (def)
  in
    ATSOPT_DEFAULT
  end (* end of [if] *)
// end of [if]
//
end // end of [atsopt_get]

(* ****** ****** *)

#define
ATSCCOMP_DEFAULT "\
gcc -std=c99 -D_XOPEN_SOURCE \
-I${PATSHOME} -I${PATSHOME}/ccomp/runtime \
-L${PATSHOME}/ccomp/atslib/lib -L${PATSHOME}/ccomp/atslib/lib64 \
"

(* ****** ****** *)

(*
(*
** HX: this one is suggested by Barry Schwartz, MN, USA
*)
#define
ATSCCOMP_DEFAULT2 "\
gcc -std=c99 \
-D_XOPEN_SOURCE \
-I${PATSHOME} -I${PATSHOME}/ccomp/runtime \
-L${PATSHOME}/ccomp/atslib/lib -L${PATSHOME}/ccomp/atslib/lib64 \
-Wl,--warn-common \
"
*)

(* ****** ****** *)

implement
{}(*tmp*)
atsccomp_get () = let
//
val def =
  $STDLIB.getenv_gc ("PATSCCOMP")
//
in
//
if
strptr2ptr (def) > 0
then strptr2string (def)
else let
  prval () = strptr_free_null(def) in ATSCCOMP_DEFAULT
end // end of [else]
//
end // end of [atsccomp_get]
  
(* ****** ****** *)

implement{}
atsccomp_get2
  (cas) = let
(*
val () = println! ("atsccomp_get2")
*)
in
//
case+ cas of
| list_cons
    (ca, cas) =>
  (
  case+ ca of
  | CAatsccomp
      (opt) => (
      if issome(opt)
        then unsome(opt) else atsccomp_get2 (cas)
      // end of [if]
    ) (* end of [CAatsccomp] *)
  | _ (*void*) => atsccomp_get2 (cas)
  ) (* end of [list_cons] *)
| list_nil () => atsccomp_get ()
//
end // end of [atsccomp_get2]

(* ****** ****** *)

(* end of [atscc_util.dats] *)

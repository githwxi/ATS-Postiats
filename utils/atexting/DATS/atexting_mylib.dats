(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2016 Hongwei Xi, ATS Trustful Software, Inc.
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
(* Authoremail: gmhwxiATgmailDOTcom *)
(* Start time: January, 2016 *)

(* ****** ****** *)

(*
#define ATS_DYNLOADFLAG 0
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)
//
#include
"libats/libc/DATS/stdio.dats"
//
(* ****** ****** *)
//
#define
HX_CSTREAM_targetloc
"$PATSHOME\
/contrib/atscntrb-hx-cstream"
//
(* ****** ****** *)

%{^
#define \
atstyarr_field_undef(fname) fname[]
%} // end of [%{]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_fun.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_cloref.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_string.dats"
in (*in-of-local *)
end // end of [local]

local
#include
"{$HX_CSTREAM}/DATS/cstream_strptr.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_fileref.dats"
in (*in-of-local *)
end // end of [local]

local
#include
"{$HX_CSTREAM}/DATS/cstream_fileptr.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

(* end of [atexting_mylib.dats] *)

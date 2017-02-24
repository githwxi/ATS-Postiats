(*
** stream of characters
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
#include 
"share/atspre_define.hats"
#include
"share/atspre_staload.hats"
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
"{$HX_CSTREAM}/DATS/cstream_fileref.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_tokener.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
//
#include"./../mylibies.dats" in (*nothing*)
//
end // end of [local]

(* ****** ****** *)

(* end of [testlib.dats] *)

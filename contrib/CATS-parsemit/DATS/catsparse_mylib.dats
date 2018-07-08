(* ****** ****** *)
//
// CATS-parsemit
//
(* ****** ****** *)
//
// HX-2014-07-02: start
//
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

#define
HX_CSTREAM_targetloc
"\
$PATSHOME/contrib\
/atscntrb/atscntrb-hx-cstream"

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream.dats"
in (* nothing *) end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_fun.dats"
in (* nothing *) end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_cloref.dats"
in (* nothing *) end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_string.dats"
in (* nothing *) end // end of [local]

local
#include
"{$HX_CSTREAM}/DATS/cstream_strptr.dats"
in (* nothing *) end // end of [local]

(* ****** ****** *)

local
#include
"{$HX_CSTREAM}/DATS/cstream_fileref.dats"
in (* nothing *) end // end of [local]

local
#include
"{$HX_CSTREAM}/DATS/cstream_fileptr.dats"
in (* nothing *) end // end of [local]

(* ****** ****** *)

%{^
#define \
atstyarr_field_undef(fname) fname[]
%} // end of [%{]

(* ****** ****** *)

(* end of [catsparse_mylib.dats] *)

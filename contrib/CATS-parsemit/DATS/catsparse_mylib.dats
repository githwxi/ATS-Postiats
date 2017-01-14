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

(* end of [catsparse_mylib.dats] *)

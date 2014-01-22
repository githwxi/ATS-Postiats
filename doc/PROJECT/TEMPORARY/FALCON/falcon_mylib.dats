(*
** mylib for [FALCON]
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

local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream.dats"
in (* in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream_fun.dats"
in (* in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream_cloref.dats"
in (* in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream_string.dats"
in (* in-of-local *)
end // end of [local]
local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream_strptr.dats"
in (* in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream_fileref.dats"
in (* in-of-local *)
end // end of [local]
local
#include
"{$LIBATSHWXI}/cstream/DATS/cstream_fileptr.dats"
in (* in-of-local *)
end // end of [local]

(* ****** ****** *)

local
//
#include
"{$LIBATSHWXI}/cstream/DATS/cstream_tokener.dats"
//
in (* in-of-local *)
end // end of [local]

(* ****** ****** *)

(* end of [falcon_mylib.dats] *)

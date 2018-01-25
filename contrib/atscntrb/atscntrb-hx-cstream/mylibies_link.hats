(* ****** ****** *)
(*
** stream of characters
*)
(* ****** ****** *)
(*
#define ATS_DYNLOADFLAG 0
*)
(* ****** ****** *)

local
#include
"./DATS/cstream.dats"
in end // end of [local]

(* ****** ****** *)

local
#include
"./DATS/cstream_fun.dats"
in end // end of [local]

(* ****** ****** *)

local
#include
"./DATS/cstream_cloref.dats"
in end // end of [local]

(* ****** ****** *)

local
#include
"./DATS/cstream_string.dats"
in end // end of [local]

local
#include
"./DATS/cstream_strptr.dats"
in end // end of [local]

(* ****** ****** *)

local
#include
"./DATS/cstream_fileref.dats"
in end // end of [local]

local
#include
"./DATS/cstream_fileptr.dats"
in end // end of [local]

(* ****** ****** *)

%{^
#define \
atstyarr_field_undef(fname) fname[]
%} // end of [%{]

(* ****** ****** *)

(* end of [mylibies_link.hats] *)

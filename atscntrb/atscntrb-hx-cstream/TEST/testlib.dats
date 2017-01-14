(*
** stream of characters
*)

(* ****** ****** *)

#define ATS_DYNLOADFLAG 0

(* ****** ****** *)
//
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
#include"./../DATS/cstream.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include"./../DATS/cstream_fun.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include"./../DATS/cstream_cloref.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include"./../DATS/cstream_string.dats"
in (*in-of-local *)
end // end of [local]

local
#include"./../DATS/cstream_strptr.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include"./../DATS/cstream_fileref.dats"
in (*in-of-local *)
end // end of [local]

local
#include"./../DATS/cstream_fileptr.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

local
#include"./../DATS/cstream_tokener.dats"
in (*in-of-local *)
end // end of [local]

(* ****** ****** *)

(* end of [testlib.dats] *)

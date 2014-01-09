(*
** stream of characters
*)

(* ****** ****** *)

staload "./../SATS/cstream.sats"

(* ****** ****** *)

typedef
cstruct = @{
  getc= (ptr) -> int
, free= (ptr) -> void
, data= @[ulint][0] // well-aligned
} (* end of [cstruct] *)

(* ****** ****** *)

datavtype
cstream = CS of cstruct
assume cstream_vtype(tk) = cstream

(* ****** ****** *)

implement
cstream_free
  (cs0) = () where
{
//
  val+@CS (cstruct) = cs0
  val () = cstruct.free (addr@(cstruct.data))
  val ((*void*)) = free@cs0
//
} // end of [cstream_free]

(* ****** ****** *)

implement
cstream_get_char
  (cs0) = ret where
{
//
  val+@CS (cstruct) = cs0
  val ret = cstruct.getc (addr@(cstruct.data))
  prval ((*void*)) = fold@cs0
//
} // end of [cstream_get_char]

(* ****** ****** *)

(* end of [cstream.dats] *)

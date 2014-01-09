(*
** stream of characters
*)

(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload "./../SATS/cstream.sats"

(* ****** ****** *)

typedef
cstruct = @{
  getc= (ptr) -> int
, free= (ptr) -> void
, data= ((*void*)) -> int
} (* end of [cstruct] *)

(* ****** ****** *)

datavtype
cstream_fun = CS of cstruct

(* ****** ****** *)

fun cstream_getc
  (p: ptr): int = ret where
{
//
typedef tfun = ((*void*)) -> int
//
val (pf, fpf | p) = $UN.ptr0_vtake{tfun}(p)
//
val ret = !p()
//
prval () = fpf (pf)
//
} (* end of [cstream_getc] *)

(* ****** ****** *)

fun cstream_free (p: ptr): void = ()

(* ****** ****** *)

implement
cstream_make_fun
  (getc) = let
//
val cs0 = CS (_)
val+CS(cstruct) = cs0
//
val () =
cstruct.getc := cstream_getc
//
val () =
cstruct.free := cstream_free
//
val () = cstruct.data := getc
//
in
  $UN.castvwtp0{cstream(TKfun)}((view@cstruct | cs0))
end // end of [cstream_make_fun]

(* ****** ****** *)

(* end of [cstream_fun.dats] *)

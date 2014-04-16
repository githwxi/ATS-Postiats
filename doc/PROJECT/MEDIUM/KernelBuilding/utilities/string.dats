(* ****** ****** *)

staload
UN = "prelude/SATS/unsafe.sats"

(* ****** ****** *)
//
extern
fun{
} memcpy
  (dst: ptr, src: ptr, n: size_t): ptr
//
(* ****** ****** *)

implmnt{ 
} memcpy (dst, src, n) = let
//
fun loop
(
  dst: ptr, src: ptr, n: size_t
) : void =
  if n > 0 then let
    val c = $UN.ptr0_get<char> (src)
    val () = $UN.ptr0_set<char> (dst, c)
  in
    loop (ptr_succ<char> (dst), ptr_succ<char> (src), pred(n))
  end else () // end of [if]
//
val ((*void*)) = loop (dst, src, n)
//
in
  dst
end (* end of [memcpy] *)

(* ****** ****** *)

(* end of [string.dats] *)

//
(* ****** ****** *)
//
// HX-2013-10-28
//
// A shared buffer implementation
//
(* ****** ****** *)

staload "./sbuffer.sats"

(* ****** ****** *)

implement{a}
buffer_insert2
  (buf, x) = let
//
val isful = buffer_isful (buf)
//
prval () = lemma_buffer_param (buf)
//
in
//
if isful
  then let
    val () =
      buffer_cond_wait_isful (buf) in buffer_insert2 (buf, x)
    // end of [val]
  end // end of [then]
  else let
    val isnil = buffer_isnil (buf)
    val ((*void*)) = buffer_insert (buf, x)
    val ((*void*)) = if isnil then buffer_cond_signal_isnil (buf)
  in
    // nothing
  end // end of [else]
//  
end // end of [buffer_insert2]

(* ****** ****** *)

implement{a}
buffer_takeout2
  (buf) = let
//
val isnil = buffer_isnil (buf)
prval () = lemma_buffer_param (buf)
//
in
//
if isnil
  then let
    val () =
      buffer_cond_wait_isnil (buf) in buffer_takeout2 (buf)
    // end of [val]
  end // end of [then]
  else (x) where
  {
    val isful = buffer_isful (buf)
    val x(*a*) = buffer_takeout (buf)
    val ((*void*)) = if isful then buffer_cond_signal_isful (buf)
  } (* end of [else] *)
//  
end // end of [buffer_takeout2]

(* ****** ****** *)

implement{a}
sbuffer_insert (sbuf, x) =
{
  val buf = sbuffer_acquire (sbuf)
  val ((*void*)) = buffer_insert2 (buf, x)
  val ((*void*)) = sbuffer_release (sbuf, buf)
}

implement{a}
sbuffer_takeout (sbuf) = x where
{
  val buf = sbuffer_acquire (sbuf)
  val x(*a*) = buffer_takeout2 (buf)
  val ((*void*)) = sbuffer_release (sbuf, buf)
}

(* ****** ****** *)

(* end of [sbuffer.dats] *)

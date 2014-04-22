(* ****** ****** *)
//
// HX-2014-04-21(start)
//
// Database reads and writes
//
(* ****** ****** *)

staload "./DB_read_write.sats"

(* ****** ****** *)
//
extern
fun SDBshell_wait_read
  {r:int}
(
  sx: SDBshell, x: !DBshell (r, 1) >> DBshell
) : void // end of [SDBshell_wait_read]
extern
fun SDBshell_wait_write
  {r,w:int | r+w >= 1}
(
  sx: SDBshell, x: !DBshell (r, w) >> DBshell
) : void // end of [SDBshell_wait_write]
//
extern fun SDBshell_signal (sx: SDBshell): void
//
(* ****** ****** *)
//
extern
fun SDBshell_acquire_read2
  (sx: SDBshell, x: !DBshell >> _): (DBread_v | void)
extern
fun SDBshell_acquire_write2
  (sx: SDBshell, x: !DBshell >> _): (DBwrite_v | void)
// 
(* ****** ****** *)

implement
SDBshell_acquire_read
  (sx) = (pf | ()) where
{
  val x = SDBshell_acquire (sx)
  val (pf | ()) = SDBshell_acquire_read2 (sx, x)
  val () = SDBshell_release (sx, x)
}

implement
SDBshell_acquire_read2
  (sx, x) = let
//
prval () =
  lemma_DBshell_param (x)
//
val w = DBshell_nwrite (x)
//
in
//
if w = 0
  then DBshell_acquire_read (x)
  else let
    val () = SDBshell_wait_read (sx, x) in SDBshell_acquire_read2 (sx, x)
  end // end of [else]
//
end // end of [SDBshell_acquire_read2]

(* ****** ****** *)

implement
SDBshell_release_read
  (pf | sx) = () where
{
  val x = SDBshell_acquire (sx)
  val () = DBshell_release_read (pf | x)
  val r = DBshell_nread (x)
  val () =
    if r = 0
      then SDBshell_signal (sx)
    // end of [if]
  val () = SDBshell_release (sx, x)
}

(* ****** ****** *)

implement
SDBshell_acquire_write
  (sx) = (pf | ()) where
{
  val x = SDBshell_acquire (sx)
  val (pf | ()) = SDBshell_acquire_write2 (sx, x)
  val () = SDBshell_release (sx, x)
}

implement
SDBshell_acquire_write2
  (sx, x) = let
//
prval () =
  lemma_DBshell_param (x)
prval () =
  lemma_DBshell_param2 (x)
//
val r = DBshell_nread (x)
//
in
//
if r = 0
  then let
    val w = DBshell_nwrite (x)
  in
    if w = 0
      then DBshell_acquire_write (x)
      else let
        val () = SDBshell_wait_write (sx, x)
      in
        SDBshell_acquire_write2 (sx, x)
      end // end of [else]
    // end of [if]
  end // end of [then]
  else let
    val () = SDBshell_wait_write (sx, x) in SDBshell_acquire_write2 (sx, x)
  end // end of [else]
//
end // end of [SDBshell_acquire_write2]

(* ****** ****** *)

implement
SDBshell_release_write
  (pf | sx) = () where
{
  val x = SDBshell_acquire (sx)
  val () = DBshell_release_write (pf | x)
  val () = SDBshell_signal (sx)
  val () = SDBshell_release (sx, x)
}

(* ****** ****** *)

(* end of [DB_read_write.dats] *)

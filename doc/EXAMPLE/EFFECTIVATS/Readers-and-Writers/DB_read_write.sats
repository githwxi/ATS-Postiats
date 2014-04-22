(* ****** ****** *)
//
// HX-2014-04-21(start)
//
// Database reads and writes
//
(* ****** ****** *)

abstype DB = ptr

(* ****** ****** *)

absview DBread_v
absview DBwrite_v

(* ****** ****** *)

fun DBread (pf: !DBread_v | db: DB): void
fun DBwrite (pf: !DBwrite_v | db: DB): void

(* ****** ****** *)
//
absvtype
DBshell (r: int, w: int) = ptr
//
vtypedef DBshell = [r,w:int] DBshell (r, w)
//
(* ****** ****** *)
//
praxi
lemma_DBshell_param
  {r,w:int} (!DBshell (r, w)): [0 <= r; 0 <= w; w <= 1] void
praxi
lemma_DBshell_param2
  {r,w:int} (!DBshell (r, w)): [r == 0 || (r > 0 && w == 0)] void
//
(* ****** ****** *)

fun DBshell_dbget (x: !DBshell): DB

(* ****** ****** *)

fun DBshell_nread {r,w:int} (x: !DBshell (r, w)): int (r)
fun DBshell_nwrite {r,w:int} (x: !DBshell (r, w)): int (w)

(* ****** ****** *)

fun DBshell_acquire_read
  {r:int} (x: !DBshell (r, 0) >> DBshell (r+1, 0)): (DBread_v | void)
fun DBshell_release_read
  {r,w:int} (pf: DBread_v | x: !DBshell (r, w) >> DBshell (r-1, w)): void

(* ****** ****** *)

fun DBshell_acquire_write
  (x: !DBshell (0, 0) >> DBshell (0, 1)): (DBwrite_v | void)
fun DBshell_release_write
  {r,w:int} (pf: DBwrite_v | x: !DBshell (r, w) >> DBshell (r, w-1)): void

(* ****** ****** *)

abstype SDBshell = ptr

(* ****** ****** *)

fun SDBshell_acquire (sx: SDBshell): DBshell
fun SDBshell_release (sx: SDBshell, x: DBshell): void

(* ****** ****** *)

fun SDBshell_acquire_read (sx: SDBshell): (DBread_v | void)
fun SDBshell_release_read (pf: DBread_v | sx: SDBshell): void

(* ****** ****** *)

fun SDBshell_acquire_write (sx: SDBshell): (DBwrite_v | void) 
fun SDBshell_release_write (pf: DBwrite_v | sx: SDBshell): void

(* ****** ****** *)

(* end of [DB_read_write.sats] *)

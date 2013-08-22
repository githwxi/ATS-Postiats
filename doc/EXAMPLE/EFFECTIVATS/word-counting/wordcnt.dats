//
// Ordering words according to the numbers
// of their occurrences of in a given file
//

(* ****** ****** *)

extern
fun fileref_get_word (FILEref): Strptr0

(* ****** ****** *)

abstype wordcnt_type
typedef wordcnt = wordcnt_type

(* ****** ****** *)

extern
fun wordcnt_get_cnt (wc: wordcnt): int
extern
fun wordcnt_get_word (wc: wordcnt): string

(* ****** ****** *)

absvtype wctable_vtype = ptr
vtypedef wctable = wctable_vtype

extern
fun fileref_counting (inp: FILEref, tbl: !wctable): void

(* ****** ****** *)

extern
fun wctable_listize_free (tbl: wctable): List_vt (wordcnt)

(* ****** ****** *)

(* end of [word-counting.dats] *)

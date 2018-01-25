(* ****** ****** *)
(*
** Author: Hongwei Xi
** Start Time: May, 2013
** Authoremail: gmhwxiATgmailDOTcom
*)
(* ****** ****** *)
//
#define
ATS_PACKNAME "ATSCNTRB.jsonc"
//
// HX: prefix for extern names
//
#define
ATS_EXTERN_PREFIX "atscntrb_jsonc_"
//
(* ****** ****** *)
//
staload JSON = "./json.sats"
//
(* ****** ****** *)
//
typedef json_bool = $JSON.json_bool
//
vtypedef lh_entry0 = $JSON.lh_entry0
vtypedef lh_entry1 = $JSON.lh_entry1
vtypedef lh_entry(l:addr) = $JSON.lh_entry(l)
//
vtypedef lh_table0 = $JSON.lh_table0
vtypedef lh_table1 = $JSON.lh_table1
vtypedef lh_table(l:addr) = $JSON.lh_table(l)
//
typedef
lh_entry_free_fn_type = $JSON.lh_entry_free_fn_type
//
typedef lh_hash_fn_type = $JSON.lh_hash_fn_type
typedef lh_equal_fn_type = $JSON.lh_equal_fn_type
//
(* ****** ****** *)
//
castfn
lh_entry2ptr
  {l:addr}(ent: !lh_entry(l)):<> ptr(l)
//
castfn
lh_table2ptr{l:addr}(tbl: !lh_table (l)):<> ptr(l)
//
castfn
ptr2lh_entry
  {l:addr}(p: ptr(l)):<> vttakeout(ptr(l), lh_entry(l))
//
(* ****** ****** *)
//
overload ptrcast with lh_entry2ptr
overload ptrcast with lh_table2ptr
//
(* ****** ****** *)
//
fun lh_entry_get_key (ent: !lh_entry1):<> Ptr0 = "mac#%"
fun lh_entry_get_val (ent: !lh_entry1):<> Ptr0 = "mac#%"
//
(* ****** ****** *)

(*
struct
lh_table*
lh_table_new
(
  int size
, const char *name
, lh_entry_free_fn *free_fn
, lh_hash_fn *hash_fn, lh_equal_fn *equal_fn
)
*)
fun lh_table_new
(
  size: intGte(0), name: string
, free_fn: lh_entry_free_fn_type
, hash_fn: lh_hash_fn_type, equal_fn: lh_equal_fn_type
) : lh_table0 = "mac#%" // end of [lh_table_new]

(* ****** ****** *)

(*
void lh_abort (const char *msg, ... )
*)

(* ****** ****** *)

(*
unsigned long lh_char_hash  (const void *k)
*)
fun lh_char_hash : lh_hash_fn_type = "mac#%"

(*
int lh_char_equal (const void *k1, const void *k2)
*)
fun lh_char_equal : lh_equal_fn_type = "mac#%"

(*
struct lh_table*
lh_kchar_table_new
  (int size, const char *name, lh_entry_free_fn *free_fn)     
*)
fun lh_kchar_table_new
(
  size: intGt(0), name: string, free_fn: lh_entry_free_fn_type
) : lh_table0 = "mac#%" // end of [lh_kchar_table_new]

(* ****** ****** *)

(*
unsigned long lh_ptr_hash  (const void *k)
*)
fun lh_ptr_hash : lh_hash_fn_type = "mac#%"

(*
int lh_ptr_equal (const void *k1, const void *k2)
*)
fun lh_ptr_equal : lh_equal_fn_type = "mac#%"

fun lh_kptr_table_new
(
  size: intGte(0), name: string, free_fn: lh_entry_free_fn_type
) : lh_table0 = "mac#%"// end of [lh_kptr_table_new]

(* ****** ****** *)

(*
void lh_table_free  (struct lh_table *t)
*)
fun lh_table_free (t: lh_table1):<!wrt> void = "mac#%"

(* ****** ****** *)

(*
int lh_table_length (struct lh_table *t)
*)
fun lh_table_length (t: !lh_table1):<> intGte(0) = "mac#%"

(* ****** ****** *)

(*
int lh_table_delete
  (struct lh_table *t, const void *k)
*)
fun lh_table_delete
  (t: !lh_table1, k: Ptr0): int(*err*) = "mac#%"

(* ****** ****** *)

(*
int lh_table_delete_entry
  (struct lh_table *t, struct lh_entry *e)
*)
fun lh_table_delete_entry
  (t: !lh_table1, e: Ptr0): int(*err*) = "mac#%"

(* ****** ****** *)

(*
int lh_table_insert
  (struct lh_table *t, void *k, const void *v)
*)
fun lh_table_insert
  (t: !lh_table1, k: Ptr0, v: Ptr0): int(*err*) = "mac#%"
          
(* ****** ****** *)
//
// HX: this one is deprecated!
//
(*
void*
lh_table_lookup(struct lh_table *t, const void *k)
*)
(*
fun lh_table_lookup
   (t: !lh_table1, k: Ptr0):<> Ptr0(*val*) = "mac#%"
// end of [lh_table_lookup]
*)
//
(* ****** ****** *)

(*
json_bool
lh_table_lookup_ex
  (struct lh_table *t, const void *k, void **v)
*)
fun lh_table_lookup_ex
  (t: !lh_table1, k: Ptr0, v: &ptr? >> Ptr0): json_bool = "mac#%"
// end of [lh_table_lookup_ex]

(* ****** ****** *)

(*
struct lh_entry*
lh_table_lookup_entry (struct lh_table *t, const void *k)
*)
fun lh_table_lookup_entry
   (t: !lh_table1, k: Ptr0):<> [l:addr] vttakeout0 (lh_entry(l)) = "mac#%"
// end of [lh_table_lookup_entry]

(* ****** ****** *)

(*
void
lh_table_resize (struct lh_table *t, int new_size)
*)
fun lh_table_resize
  (t: !lh_table1, new_size: intGte(0)): void = "mac#%"
// end of [lh_table_resize]

(* ****** ****** *)

(* end of [linkhash.sats] *)

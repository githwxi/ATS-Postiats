(*
** Module [file]
*)

(* ****** ****** *)
//
// HX-2015-09:
// prefix for external names
//
#define
ATS_EXTERN_PREFIX "ats2erlibc_file_"
//
(* ****** ****** *)
//
staload
"./../../basics_erl.sats"
//
(* ****** ****** *)

abstype
deep_list // [char | atom | deep_list]

(* ****** ****** *)

abstype fd // for raw file descriptors

(* ****** ****** *)

abstype filename // = string
abstype filename_all // = string | binary

(* ****** ****** *)

abstype io_device // = pid | fd

(* ****** ****** *)

abstype name // = string | atom | deep_list
abstype name_all // = name | RawFilename::binary

(* ****** ****** *)

abstype mode
abstype location

(* ****** ****** *)

abstype posix(*errno*)

(* ****** ****** *)

abstype data_time // = Calendar::datatime

(* ****** ****** *)

abstype file_info_option  
  
(* ****** ****** *)
//
castfn
filename2string: filename -> string
//
(* ****** ****** *)

fun
filename_all2string: filename_all -> string = "mac#%"

(* ****** ****** *)
//
fun print_filename: filename -> void = "mac#%"
fun print_filename_all: filename_all -> void = "mac#%"
//
overload print with print_filename
overload print with print_filename_all
//
(* ****** ****** *)
//
(*
get_cwd_0() = $extfcall(ERLval, "file:get_cwd")
get_cwd_1(Drive) = $extfcall(ERLval, "file:get_cwd", Drive)
*)
//
fun
ats2get_cwd_0_opt(): Option(filename) = "mac#%"
fun
ats2get_cwd_1_opt(Drive: string): Option(filename) = "mac#%"
//
overload ats2get_cwd_opt with ats2get_cwd_0_opt
overload ats2get_cwd_opt with ats2get_cwd_1_opt
//
(* ****** ****** *)
//
fun
ats2del_dir_opt(Dir: name_all): bool = "mac#%"
//
(* ****** ****** *)
//
fun
ats2list_dir_opt
  (Dir: name_all): Option(ERLlist(filename)) = "mac#%"
fun
ats2list_dir_all_opt
  (Dir: name_all): Option(ERLlist(filename_all)) = "mac#%"
//
(* ****** ****** *)
//
fun
ats2make_dir_opt(Dir: name_all): bool = "mac#%"
//
fun
ats2make_link_opt
  (Existing: name_all, New: name_all): bool = "mac#%"
fun
ats2make_symlink_opt
  (Existing: name_all, New: name_all): bool = "mac#%"
//
(* ****** ****** *)
//
fun
ats2read_file_opt
  (Filename: name_all): Option(binary) = "mac#%"
//
(* ****** ****** *)
//
fun
ats2rename_opt // ok/error: true/false
  (Source: name_all, Destination: name_all): bool = "mac#%"
//
(* ****** ****** *)
//
fun
ats2set_cwd(Dir: name): bool = "mac#%" // ok/error: true/false
//
(* ****** ****** *)

(* end of [file.sats] *)

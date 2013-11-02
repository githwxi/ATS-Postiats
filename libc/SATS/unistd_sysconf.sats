(***********************************************************************)
(*                                                                     *)
(*                         Applied Type System                         *)
(*                                                                     *)
(***********************************************************************)

(*
** ATS/Postiats - Unleashing the Potential of Types!
** Copyright (C) 2011-2013 Hongwei Xi, ATS Trustful Software, Inc.
** All rights reserved
**
** ATS is free software;  you can  redistribute it and/or modify it under
** the terms of  the GNU GENERAL PUBLIC LICENSE (GPL) as published by the
** Free Software Foundation; either version 3, or (at  your  option)  any
** later version.
** 
** ATS is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without  even  the  implied  warranty  of MERCHANTABILITY or
** FITNESS FOR A PARTICULAR PURPOSE.  See the  GNU General Public License
** for more details.
** 
** You  should  have  received  a  copy of the GNU General Public License
** along  with  ATS;  see the  file COPYING.  If not, please write to the
** Free Software Foundation,  51 Franklin Street, Fifth Floor, Boston, MA
** 02110-1301, USA.
*)

(* ****** ****** *)

(* Author: Hongwei Xi *)
(* Authoremail: hwxi AT cs DOT bu DOT edu *)
(* Start time: April, 2012 *)

(* ****** ****** *)

typedef sysconfname = int

(* ****** ****** *)
//
// HX: error reporting:
// -1 is returned and errno is set
//
fun sysconf (name: sysconfname): lint = "mac#%"
//
(* ****** ****** *)

macdef _SC_ARG_MAX = $extval (sysconfname, "_SC_ARG_MAX")
macdef _SC_CHILD_MAX = $extval (sysconfname, "_SC_CHILD_MAX")
macdef _SC_CLK_TCK = $extval (sysconfname, "_SC_CLK_TCK")
macdef _SC_NGROUPS_MAX = $extval (sysconfname, "_SC_NGROUPS_MAX")
macdef _SC_OPEN_MAX = $extval (sysconfname, "_SC_OPEN_MAX")
macdef _SC_STREAM_MAX = $extval (sysconfname, "_SC_STREAM_MAX")
macdef _SC_TZNAME_MAX = $extval (sysconfname, "_SC_TZNAME_MAX")
macdef _SC_JOB_CONTROL = $extval (sysconfname, "_SC_JOB_CONTROL")
macdef _SC_SAVED_IDS = $extval (sysconfname, "_SC_SAVED_IDS")
macdef _SC_REALTIME_SIGNALS = $extval (sysconfname, "_SC_REALTIME_SIGNALS")
macdef _SC_PRIORITY_SCHEDULING = $extval (sysconfname, "_SC_PRIORITY_SCHEDULING")
macdef _SC_TIMERS = $extval (sysconfname, "_SC_TIMERS")
macdef _SC_ASYNCHRONOUS_IO = $extval (sysconfname, "_SC_ASYNCHRONOUS_IO")
macdef _SC_PRIORITIZED_IO = $extval (sysconfname, "_SC_PRIORITIZED_IO")
macdef _SC_SYNCHRONIZED_IO = $extval (sysconfname, "_SC_SYNCHRONIZED_IO")
macdef _SC_FSYNC = $extval (sysconfname, "_SC_FSYNC")
macdef _SC_MAPPED_FILES = $extval (sysconfname, "_SC_MAPPED_FILES")
macdef _SC_MEMLOCK = $extval (sysconfname, "_SC_MEMLOCK")
macdef _SC_MEMLOCK_RANGE = $extval (sysconfname, "_SC_MEMLOCK_RANGE")
macdef _SC_MEMORY_PROTECTION = $extval (sysconfname, "_SC_MEMORY_PROTECTION")
macdef _SC_MESSAGE_PASSING = $extval (sysconfname, "_SC_MESSAGE_PASSING")
macdef _SC_SEMAPHORES = $extval (sysconfname, "_SC_SEMAPHORES")
macdef _SC_SHARED_MEMORY_OBJECTS = $extval (sysconfname, "_SC_SHARED_MEMORY_OBJECTS")
macdef _SC_AIO_LISTIO_MAX = $extval (sysconfname, "_SC_AIO_LISTIO_MAX")
macdef _SC_AIO_MAX = $extval (sysconfname, "_SC_AIO_MAX")
macdef _SC_AIO_PRIO_DELTA_MAX = $extval (sysconfname, "_SC_AIO_PRIO_DELTA_MAX")
macdef _SC_DELAYTIMER_MAX = $extval (sysconfname, "_SC_DELAYTIMER_MAX")
macdef _SC_MQ_OPEN_MAX = $extval (sysconfname, "_SC_MQ_OPEN_MAX")
macdef _SC_MQ_PRIO_MAX = $extval (sysconfname, "_SC_MQ_PRIO_MAX")
macdef _SC_VERSION = $extval (sysconfname, "_SC_VERSION")
macdef _SC_PAGESIZE = $extval (sysconfname, "_SC_PAGESIZE")
macdef _SC_PAGE_SIZE = $extval (sysconfname, "_SC_PAGE_SIZE")
macdef _SC_RTSIG_MAX = $extval (sysconfname, "_SC_RTSIG_MAX")
macdef _SC_SEM_NSEMS_MAX = $extval (sysconfname, "_SC_SEM_NSEMS_MAX")
macdef _SC_SEM_VALUE_MAX = $extval (sysconfname, "_SC_SEM_VALUE_MAX")
macdef _SC_SIGQUEUE_MAX = $extval (sysconfname, "_SC_SIGQUEUE_MAX")
macdef _SC_TIMER_MAX = $extval (sysconfname, "_SC_TIMER_MAX")
//
macdef _SC_BC_BASE_MAX = $extval (sysconfname, "_SC_BC_BASE_MAX")
macdef _SC_BC_DIM_MAX = $extval (sysconfname, "_SC_BC_DIM_MAX")
macdef _SC_BC_SCALE_MAX = $extval (sysconfname, "_SC_BC_SCALE_MAX")
macdef _SC_BC_STRING_MAX = $extval (sysconfname, "_SC_BC_STRING_MAX")
macdef _SC_COLL_WEIGHTS_MAX = $extval (sysconfname, "_SC_COLL_WEIGHTS_MAX")
macdef _SC_EQUIV_CLASS_MAX = $extval (sysconfname, "_SC_EQUIV_CLASS_MAX")
macdef _SC_EXPR_NEST_MAX = $extval (sysconfname, "_SC_EXPR_NEST_MAX")
macdef _SC_LINE_MAX = $extval (sysconfname, "_SC_LINE_MAX")
macdef _SC_RE_DUP_MAX = $extval (sysconfname, "_SC_RE_DUP_MAX")
macdef _SC_CHARCLASS_NAME_MAX = $extval (sysconfname, "_SC_CHARCLASS_NAME_MAX")
//
macdef _SC_2_VERSION = $extval (sysconfname, "_SC_2_VERSION")
macdef _SC_2_C_BIND = $extval (sysconfname, "_SC_2_C_BIND")
macdef _SC_2_C_DEV = $extval (sysconfname, "_SC_2_C_DEV")
macdef _SC_2_FORT_DEV = $extval (sysconfname, "_SC_2_FORT_DEV")
macdef _SC_2_FORT_RUN = $extval (sysconfname, "_SC_2_FORT_RUN")
macdef _SC_2_SW_DEV = $extval (sysconfname, "_SC_2_SW_DEV")
macdef _SC_2_LOCALEDEF = $extval (sysconfname, "_SC_2_LOCALEDEF")
//
macdef _SC_PII = $extval (sysconfname, "_SC_PII")
macdef _SC_PII_XTI = $extval (sysconfname, "_SC_PII_XTI")
macdef _SC_PII_SOCKET = $extval (sysconfname, "_SC_PII_SOCKET")
macdef _SC_PII_INTERNET = $extval (sysconfname, "_SC_PII_INTERNET")
macdef _SC_PII_OSI = $extval (sysconfname, "_SC_PII_OSI")
macdef _SC_POLL = $extval (sysconfname, "_SC_POLL")
macdef _SC_SELECT = $extval (sysconfname, "_SC_SELECT")
macdef _SC_UIO_MAXIOV = $extval (sysconfname, "_SC_UIO_MAXIOV")
macdef _SC_IOV_MAX = _SC_UIO_MAXIOV = $extval (sysconfname, "_SC_IOV_MAX = _SC_UIO_MAXIOV")
macdef _SC_PII_INTERNET_STREAM = $extval (sysconfname, "_SC_PII_INTERNET_STREAM")
macdef _SC_PII_INTERNET_DGRAM = $extval (sysconfname, "_SC_PII_INTERNET_DGRAM")
macdef _SC_PII_OSI_COTS = $extval (sysconfname, "_SC_PII_OSI_COTS")
macdef _SC_PII_OSI_CLTS = $extval (sysconfname, "_SC_PII_OSI_CLTS")
macdef _SC_PII_OSI_M = $extval (sysconfname, "_SC_PII_OSI_M")
macdef _SC_T_IOV_MAX = $extval (sysconfname, "_SC_T_IOV_MAX")
//
macdef _SC_THREADS = $extval (sysconfname, "_SC_THREADS")
macdef _SC_THREAD_SAFE_FUNCTIONS =
  $extval (sysconfname, "_SC_THREAD_SAFE_FUNCTIONS")
macdef _SC_GETGR_R_SIZE_MAX = $extval (sysconfname, "_SC_GETGR_R_SIZE_MAX")
macdef _SC_GETPW_R_SIZE_MAX = $extval (sysconfname, "_SC_GETPW_R_SIZE_MAX")
macdef _SC_LOGIN_NAME_MAX = $extval (sysconfname, "_SC_LOGIN_NAME_MAX")
macdef _SC_TTY_NAME_MAX = $extval (sysconfname, "_SC_TTY_NAME_MAX")
macdef _SC_THREAD_DESTRUCTOR_ITERATIONS =
  $extval (sysconfname, "_SC_THREAD_DESTRUCTOR_ITERATIONS")
macdef _SC_THREAD_KEYS_MAX = $extval (sysconfname, "_SC_THREAD_KEYS_MAX")
macdef _SC_THREAD_STACK_MIN = $extval (sysconfname, "_SC_THREAD_STACK_MIN")
macdef _SC_THREAD_THREADS_MAX = $extval (sysconfname, "_SC_THREAD_THREADS_MAX")
macdef _SC_THREAD_ATTR_STACKADDR = $extval (sysconfname, "_SC_THREAD_ATTR_STACKADDR")
macdef _SC_THREAD_ATTR_STACKSIZE = $extval (sysconfname, "_SC_THREAD_ATTR_STACKSIZE")
macdef _SC_THREAD_PRIORITY_SCHEDULING =
  $extval (sysconfname, "_SC_THREAD_PRIORITY_SCHEDULING")
macdef _SC_THREAD_PRIO_INHERIT = $extval (sysconfname, "_SC_THREAD_PRIO_INHERIT")
macdef _SC_THREAD_PRIO_PROTECT = $extval (sysconfname, "_SC_THREAD_PRIO_PROTECT")
macdef _SC_THREAD_PROCESS_SHARED = $extval (sysconfname, "_SC_THREAD_PROCESS_SHARED")
//
macdef _SC_NPROCESSORS_CONF = $extval (sysconfname, "_SC_NPROCESSORS_CONF")
macdef _SC_NPROCESSORS_ONLN = $extval (sysconfname, "_SC_NPROCESSORS_ONLN")
macdef _SC_PHYS_PAGES = $extval (sysconfname, "_SC_PHYS_PAGES")
macdef _SC_AVPHYS_PAGES = $extval (sysconfname, "_SC_AVPHYS_PAGES")
macdef _SC_ATEXIT_MAX = $extval (sysconfname, "_SC_ATEXIT_MAX")
macdef _SC_PASS_MAX = $extval (sysconfname, "_SC_PASS_MAX")
//
macdef _SC_XOPEN_VERSION = $extval (sysconfname, "_SC_XOPEN_VERSION")
macdef _SC_XOPEN_XCU_VERSION = $extval (sysconfname, "_SC_XOPEN_XCU_VERSION")
macdef _SC_XOPEN_UNIX = $extval (sysconfname, "_SC_XOPEN_UNIX")
macdef _SC_XOPEN_CRYPT = $extval (sysconfname, "_SC_XOPEN_CRYPT")
macdef _SC_XOPEN_ENH_I18N = $extval (sysconfname, "_SC_XOPEN_ENH_I18N")
macdef _SC_XOPEN_SHM = $extval (sysconfname, "_SC_XOPEN_SHM")
//
macdef _SC_2_CHAR_TERM = $extval (sysconfname, "_SC_2_CHAR_TERM")
macdef _SC_2_C_VERSION = $extval (sysconfname, "_SC_2_C_VERSION")
macdef _SC_2_UPE = $extval (sysconfname, "_SC_2_UPE")
//
macdef _SC_XOPEN_XPG2 = $extval (sysconfname, "_SC_XOPEN_XPG2")
macdef _SC_XOPEN_XPG3 = $extval (sysconfname, "_SC_XOPEN_XPG3")
macdef _SC_XOPEN_XPG4 = $extval (sysconfname, "_SC_XOPEN_XPG4")
//
macdef _SC_CHAR_BIT = $extval (sysconfname, "_SC_CHAR_BIT")
macdef _SC_CHAR_MAX = $extval (sysconfname, "_SC_CHAR_MAX")
macdef _SC_CHAR_MIN = $extval (sysconfname, "_SC_CHAR_MIN")
macdef _SC_INT_MAX = $extval (sysconfname, "_SC_INT_MAX")
macdef _SC_INT_MIN = $extval (sysconfname, "_SC_INT_MIN")
macdef _SC_LONG_BIT = $extval (sysconfname, "_SC_LONG_BIT")
macdef _SC_WORD_BIT = $extval (sysconfname, "_SC_WORD_BIT")
macdef _SC_MB_LEN_MAX = $extval (sysconfname, "_SC_MB_LEN_MAX")
macdef _SC_NZERO = $extval (sysconfname, "_SC_NZERO")
macdef _SC_SSIZE_MAX = $extval (sysconfname, "_SC_SSIZE_MAX")
macdef _SC_SCHAR_MAX = $extval (sysconfname, "_SC_SCHAR_MAX")
macdef _SC_SCHAR_MIN = $extval (sysconfname, "_SC_SCHAR_MIN")
macdef _SC_SHRT_MAX = $extval (sysconfname, "_SC_SHRT_MAX")
macdef _SC_SHRT_MIN = $extval (sysconfname, "_SC_SHRT_MIN")
macdef _SC_UCHAR_MAX = $extval (sysconfname, "_SC_UCHAR_MAX")
macdef _SC_UINT_MAX = $extval (sysconfname, "_SC_UINT_MAX")
macdef _SC_ULONG_MAX = $extval (sysconfname, "_SC_ULONG_MAX")
macdef _SC_USHRT_MAX = $extval (sysconfname, "_SC_USHRT_MAX")
//
macdef _SC_NL_ARGMAX = $extval (sysconfname, "_SC_NL_ARGMAX")
macdef _SC_NL_LANGMAX = $extval (sysconfname, "_SC_NL_LANGMAX")
macdef _SC_NL_MSGMAX = $extval (sysconfname, "_SC_NL_MSGMAX")
macdef _SC_NL_NMAX = $extval (sysconfname, "_SC_NL_NMAX")
macdef _SC_NL_SETMAX = $extval (sysconfname, "_SC_NL_SETMAX")
macdef _SC_NL_TEXTMAX = $extval (sysconfname, "_SC_NL_TEXTMAX")
//
macdef _SC_XBS5_ILP32_OFF32 = $extval (sysconfname, "_SC_XBS5_ILP32_OFF32")
macdef _SC_XBS5_ILP32_OFFBIG = $extval (sysconfname, "_SC_XBS5_ILP32_OFFBIG")
macdef _SC_XBS5_LP64_OFF64 = $extval (sysconfname, "_SC_XBS5_LP64_OFF64")
macdef _SC_XBS5_LPBIG_OFFBIG = $extval (sysconfname, "_SC_XBS5_LPBIG_OFFBIG")
//
macdef _SC_XOPEN_LEGACY = $extval (sysconfname, "_SC_XOPEN_LEGACY")
macdef _SC_XOPEN_REALTIME = $extval (sysconfname, "_SC_XOPEN_REALTIME")
macdef _SC_XOPEN_REALTIME_THREADS = $extval (sysconfname, "_SC_XOPEN_REALTIME_THREADS")
//
macdef _SC_ADVISORY_INFO =
  $extval (sysconfname, "_SC_ADVISORY_INFO")
macdef _SC_BARRIERS = $extval (sysconfname, "_SC_BARRIERS")
macdef _SC_BASE = $extval (sysconfname, "_SC_BASE")
macdef _SC_C_LANG_SUPPORT =
  $extval (sysconfname, "_SC_C_LANG_SUPPORT")
macdef _SC_C_LANG_SUPPORT_R =
  $extval (sysconfname, "_SC_C_LANG_SUPPORT_R")
macdef _SC_CLOCK_SELECTION = $extval (sysconfname, "_SC_CLOCK_SELECTION")
macdef _SC_CPUTIME = $extval (sysconfname, "_SC_CPUTIME")
macdef _SC_THREAD_CPUTIME = $extval (sysconfname, "_SC_THREAD_CPUTIME")
macdef _SC_DEVICE_IO = $extval (sysconfname, "_SC_DEVICE_IO")
macdef _SC_DEVICE_SPECIFIC = $extval (sysconfname, "_SC_DEVICE_SPECIFIC")
macdef _SC_DEVICE_SPECIFIC_R = $extval (sysconfname, "_SC_DEVICE_SPECIFIC_R")
macdef _SC_FD_MGMT = $extval (sysconfname, "_SC_FD_MGMT")
macdef _SC_FIFO = $extval (sysconfname, "_SC_FIFO")
macdef _SC_PIPE = $extval (sysconfname, "_SC_PIPE")
macdef _SC_FILE_ATTRIBUTES = $extval (sysconfname, "_SC_FILE_ATTRIBUTES")
macdef _SC_FILE_LOCKING = $extval (sysconfname, "_SC_FILE_LOCKING")
macdef _SC_FILE_SYSTEM = $extval (sysconfname, "_SC_FILE_SYSTEM")
macdef _SC_MONOTONIC_CLOCK = $extval (sysconfname, "_SC_MONOTONIC_CLOCK")
macdef _SC_MULTI_PROCESS = $extval (sysconfname, "_SC_MULTI_PROCESS")
macdef _SC_SINGLE_PROCESS = $extval (sysconfname, "_SC_SINGLE_PROCESS")
macdef _SC_NETWORKING = $extval (sysconfname, "_SC_NETWORKING")
macdef _SC_READER_WRITER_LOCKS =
  $extval (sysconfname, "_SC_READER_WRITER_LOCKS")
macdef _SC_SPIN_LOCKS = $extval (sysconfname, "_SC_SPIN_LOCKS")
macdef _SC_REGEXP = $extval (sysconfname, "_SC_REGEXP")
macdef _SC_REGEX_VERSION = $extval (sysconfname, "_SC_REGEX_VERSION")
macdef _SC_SHELL = $extval (sysconfname, "_SC_SHELL")
macdef _SC_SIGNALS = $extval (sysconfname, "_SC_SIGNALS")
macdef _SC_SPAWN = $extval (sysconfname, "_SC_SPAWN")
macdef _SC_SPORADIC_SERVER = $extval (sysconfname, "_SC_SPORADIC_SERVER")
macdef _SC_THREAD_SPORADIC_SERVER =
  $extval (sysconfname, "_SC_THREAD_SPORADIC_SERVER")
macdef _SC_SYSTEM_DATABASE =
  $extval (sysconfname, "_SC_SYSTEM_DATABASE")
macdef _SC_SYSTEM_DATABASE_R =
  $extval (sysconfname, "_SC_SYSTEM_DATABASE_R")
macdef _SC_TIMEOUTS = $extval (sysconfname, "_SC_TIMEOUTS")
macdef _SC_TYPED_MEMORY_OBJECTS =
  $extval (sysconfname, "_SC_TYPED_MEMORY_OBJECTS")
macdef _SC_USER_GROUPS = $extval (sysconfname, "_SC_USER_GROUPS")
macdef _SC_USER_GROUPS_R = $extval (sysconfname, "_SC_USER_GROUPS_R")
macdef _SC_2_PBS = $extval (sysconfname, "_SC_2_PBS")
macdef _SC_2_PBS_ACCOUNTING = $extval (sysconfname, "_SC_2_PBS_ACCOUNTING")
macdef _SC_2_PBS_LOCATE = $extval (sysconfname, "_SC_2_PBS_LOCATE")
macdef _SC_2_PBS_MESSAGE = $extval (sysconfname, "_SC_2_PBS_MESSAGE")
macdef _SC_2_PBS_TRACK = $extval (sysconfname, "_SC_2_PBS_TRACK")
macdef _SC_SYMLOOP_MAX = $extval (sysconfname, "_SC_SYMLOOP_MAX")
macdef _SC_STREAMS = $extval (sysconfname, "_SC_STREAMS")
macdef _SC_2_PBS_CHECKPOINT = $extval (sysconfname, "_SC_2_PBS_CHECKPOINT")
//
macdef _SC_V6_ILP32_OFF32 = $extval (sysconfname, "_SC_V6_ILP32_OFF32")
macdef _SC_V6_ILP32_OFFBIG = $extval (sysconfname, "_SC_V6_ILP32_OFFBIG")
macdef _SC_V6_LP64_OFF64 = $extval (sysconfname, "_SC_V6_LP64_OFF64")
macdef _SC_V6_LPBIG_OFFBIG = $extval (sysconfname, "_SC_V6_LPBIG_OFFBIG")
//
macdef _SC_HOST_NAME_MAX =
  $extval (sysconfname, "_SC_HOST_NAME_MAX")
macdef _SC_TRACE = $extval (sysconfname, "_SC_TRACE")
macdef _SC_TRACE_EVENT_FILTER =
  $extval (sysconfname, "_SC_TRACE_EVENT_FILTER")
macdef _SC_TRACE_INHERIT =
  $extval (sysconfname, "_SC_TRACE_INHERIT")
macdef _SC_TRACE_LOG = $extval (sysconfname, "_SC_TRACE_LOG")
//
macdef _SC_LEVEL1_ICACHE_SIZE =
  $extval (sysconfname, "_SC_LEVEL1_ICACHE_SIZE")
macdef _SC_LEVEL1_ICACHE_ASSOC =
  $extval (sysconfname, "_SC_LEVEL1_ICACHE_ASSOC")
macdef _SC_LEVEL1_ICACHE_LINESIZE =
  $extval (sysconfname, "_SC_LEVEL1_ICACHE_LINESIZE")
macdef _SC_LEVEL1_DCACHE_SIZE =
  $extval (sysconfname, "_SC_LEVEL1_DCACHE_SIZE")
macdef _SC_LEVEL1_DCACHE_ASSOC =
  $extval (sysconfname, "_SC_LEVEL1_DCACHE_ASSOC")
macdef _SC_LEVEL1_DCACHE_LINESIZE =
  $extval (sysconfname, "_SC_LEVEL1_DCACHE_LINESIZE")
macdef _SC_LEVEL2_CACHE_SIZE =
  $extval (sysconfname, "_SC_LEVEL2_CACHE_SIZE")
macdef _SC_LEVEL2_CACHE_ASSOC =
  $extval (sysconfname, "_SC_LEVEL2_CACHE_ASSOC")
macdef _SC_LEVEL2_CACHE_LINESIZE =
  $extval (sysconfname, "_SC_LEVEL2_CACHE_LINESIZE")
macdef _SC_LEVEL3_CACHE_SIZE =
  $extval (sysconfname, "_SC_LEVEL3_CACHE_SIZE")
macdef _SC_LEVEL3_CACHE_ASSOC =
  $extval (sysconfname, "_SC_LEVEL3_CACHE_ASSOC")
macdef _SC_LEVEL3_CACHE_LINESIZE =
  $extval (sysconfname, "_SC_LEVEL3_CACHE_LINESIZE")
macdef _SC_LEVEL4_CACHE_SIZE =
  $extval (sysconfname, "_SC_LEVEL4_CACHE_SIZE")
macdef _SC_LEVEL4_CACHE_ASSOC =
  $extval (sysconfname, "_SC_LEVEL4_CACHE_ASSOC")
macdef _SC_LEVEL4_CACHE_LINESIZE =
  $extval (sysconfname, "_SC_LEVEL4_CACHE_LINESIZE")
//
macdef _SC_IPV6 = $extval (sysconfname, "_SC_IPV6")
macdef _SC_RAW_SOCKETS = $extval (sysconfname, "_SC_RAW_SOCKETS")
//
macdef _SC_V7_ILP32_OFF32 = $extval (sysconfname, "_SC_V7_ILP32_OFF32")
macdef _SC_V7_ILP32_OFFBIG = $extval (sysconfname, "_SC_V7_ILP32_OFFBIG")
macdef _SC_V7_LP64_OFF64 = $extval (sysconfname, "_SC_V7_LP64_OFF64")
macdef _SC_V7_LPBIG_OFFBIG = $extval (sysconfname, "_SC_V7_LPBIG_OFFBIG")
//
macdef _SC_SS_REPL_MAX = $extval (sysconfname, "_SC_SS_REPL_MAX")
//
macdef _SC_TRACE_EVENT_NAME_MAX =
  $extval (sysconfname, "_SC_TRACE_EVENT_NAME_MAX")
macdef _SC_TRACE_NAME_MAX =
  $extval (sysconfname, "_SC_TRACE_NAME_MAX")
macdef _SC_TRACE_SYS_MAX =
  $extval (sysconfname, "_SC_TRACE_SYS_MAX")
macdef _SC_TRACE_USER_EVENT_MAX =
  $extval (sysconfname, "_SC_TRACE_USER_EVENT_MAX")
//
macdef _SC_XOPEN_STREAMS =
  $extval (sysconfname, "_SC_XOPEN_STREAMS")
//
macdef _SC_THREAD_ROBUST_PRIO_INHERIT =
  $extval (sysconfname, "_SC_THREAD_ROBUST_PRIO_INHERIT")
macdef _SC_THREAD_ROBUST_PRIO_PROTEC =
  $extval (sysconfname, "_SC_THREAD_ROBUST_PRIO_PROTEC")

(* ****** ****** *)

(* end of [unistd_sysconf.sats] *)

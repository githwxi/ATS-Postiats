(*
** for testing [libc/stdlib]
*)

(* ****** ****** *)
//
#include
"share/atspre_staload.hats"
//
(* ****** ****** *)

staload
UNSAFE = "prelude/SATS/unsafe.sats"

(* ****** ****** *)

staload UNI = "libc/SATS/unistd.sats"

(* ****** ****** *)

staload "libc/SATS/errno.sats"

(* ****** ****** *)

staload "libc/SATS/string.sats"
staload _ = "libc/DATS/string.dats"

(* ****** ****** *)

val () =
{
//
val str = "abcde"
val str2 = "abcdef"
//
val () = assertloc (strcmp (str, str2) < 0)
val () = assertloc (strcmp (str2, str) > 0)
val () = assertloc (strncmp (str, str2, strlen (str)) = 0)
//
val () = assertloc (strspn (str, str) = 5)
val () = assertloc (strcspn (str, str) = 0)
//
val _0 = i2sz(0)
val () = assertloc (_0 = strnlen (str, _0))
val () = assertloc (strlen (str) = strnlen (str, i2sz(1000000)))
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val str = "abcde"
val str2 = string0_copy ("_____")
val p = strcpy_unsafe (strptr2ptr(str2), str)
val () = assertloc (str = $UNSAFE.strptr2string(str2))
val () = strptr_free (str2)
//
} // end of [val]

val () =
{
//
val str = "fghij"
val str2 = string0_copy ("abcde_____")
val p0 = strptr2ptr(str2)
val p5 = ptr_add<char> (p0, 5)
val () = $UNSAFE.ptr0_set<char> (p5, '\000')
val p = strcat_unsafe (p0, str)
val () = assertloc ("abcdefghij" = $UNSAFE.strptr2string(str2))
val () = strptr_free (str2)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val str = "abcde"
val (pf | str2) = strdup (str)
val () = assertloc (str = $UNSAFE.castvwtp1{string}(str2))
val () = strdup_free (pf | str2)
//
val (pf | str2) = strdupa (str)
val () = assertloc (str = $UNSAFE.castvwtp1{string}(str2))
val () = strdupa_free (pf | str2)
//
} // end f [val]

(* ****** ****** *)

val () =
{
//
val str = "abcde"
val str2 = string0_copy (str)
val p2 = strfry (str2)
val () = assertloc (p2 = strptr2ptr(str2))
val () = println! ("strfry(", str, ") = ", str2)
val () = strptr_free (str2)
//
} // end of [val]

(* ****** ****** *)

val () =
{
//
val ENONEstr = strerror_r_gc (ENONE)
val () = println! ("ENONE(", ENONE, ") = ", ENONEstr)
val () = strptr_free (ENONEstr)
//
val E2BIGstr = strerror_r_gc (E2BIG)
val () = println! ("E2BIG(", E2BIG, ") = ", E2BIGstr)
val () = strptr_free (E2BIGstr)
//
val EACCESstr = strerror_r_gc (EACCES)
val () = println! ("EACCES(", EACCES, ") = ", EACCESstr)
val () = strptr_free (EACCESstr)
//
val EADDRINUSEstr = strerror_r_gc (EADDRINUSE)
val () = println! ("EADDRINUSE(", EADDRINUSE, ") = ", EADDRINUSEstr)
val () = strptr_free (EADDRINUSEstr)
//
val EADDRNOTAVAILstr = strerror_r_gc (EADDRNOTAVAIL)
val () = println! ("EADDRNOTAVAIL(", EADDRNOTAVAIL, ") = ", EADDRNOTAVAILstr)
val () = strptr_free (EADDRNOTAVAILstr)
//
val EAGAINstr = strerror_r_gc (EAGAIN)
val () = println! ("EAGAIN(", EAGAIN, ") = ", EAGAINstr)
val () = strptr_free (EAGAINstr)
//
val EALREADYstr = strerror_r_gc (EALREADY)
val () = println! ("EALREADY(", EALREADY, ") = ", EALREADYstr)
val () = strptr_free (EALREADYstr)
//
val EBADFstr = strerror_r_gc (EBADF)
val () = println! ("EBADF(", EBADF, ") = ", EBADFstr)
val () = strptr_free (EBADFstr)
//
val EBADMSGstr = strerror_r_gc (EBADMSG)
val () = println! ("EBADMSG(", EBADMSG, ") = ", EBADMSGstr)
val () = strptr_free (EBADMSGstr)
//
val ECANCELEDstr = strerror_r_gc (ECANCELED)
val () = println! ("ECANCELED(", ECANCELED, ") = ", ECANCELEDstr)
val () = strptr_free (ECANCELEDstr)
//
val ECHILDstr = strerror_r_gc (ECHILD)
val () = println! ("ECHILD(", ECHILD, ") = ", ECHILDstr)
val () = strptr_free (ECHILDstr)
//
val ECONNABORTEDstr = strerror_r_gc (ECONNABORTED)
val () = println! ("ECONNABORTED(", ECONNABORTED, ") = ", ECONNABORTEDstr)
val () = strptr_free (ECONNABORTEDstr)
//
val ECONNREFUSEDstr = strerror_r_gc (ECONNREFUSED)
val () = println! ("ECONNREFUSED(", ECONNREFUSED, ") = ", ECONNREFUSEDstr)
val () = strptr_free (ECONNREFUSEDstr)
//
val ECONNRESETstr = strerror_r_gc (ECONNRESET)
val () = println! ("ECONNRESET(", ECONNRESET, ") = ", ECONNRESETstr)
val () = strptr_free (ECONNRESETstr)
//
val EDEADLKstr = strerror_r_gc (EDEADLK)
val () = println! ("EDEADLK(", EDEADLK, ") = ", EDEADLKstr)
val () = strptr_free (EDEADLKstr)
//
val EDESTADDRREQstr = strerror_r_gc (EDESTADDRREQ)
val () = println! ("EDESTADDRREQ(", EDESTADDRREQ, ") = ", EDESTADDRREQstr)
val () = strptr_free (EDESTADDRREQstr)
//
val EDOMstr = strerror_r_gc (EDOM)
val () = println! ("EDOM(", EDOM, ") = ", EDOMstr)
val () = strptr_free (EDOMstr)
//
val EEXISTstr = strerror_r_gc (EEXIST)
val () = println! ("EEXIST(", EEXIST, ") = ", EEXISTstr)
val () = strptr_free (EEXISTstr)
//
val EFAULTstr = strerror_r_gc (EFAULT)
val () = println! ("EFAULT(", EFAULT, ") = ", EFAULTstr)
val () = strptr_free (EFAULTstr)
//
val EFBIGstr = strerror_r_gc (EFBIG)
val () = println! ("EFBIG(", EFBIG, ") = ", EFBIGstr)
val () = strptr_free (EFBIGstr)
//
val EHOSTUNREACHstr = strerror_r_gc (EHOSTUNREACH)
val () = println! ("EHOSTUNREACH(", EHOSTUNREACH, ") = ", EHOSTUNREACHstr)
val () = strptr_free (EHOSTUNREACHstr)
//
val EIDRMstr = strerror_r_gc (EIDRM)
val () = println! ("EIDRM(", EIDRM, ") = ", EIDRMstr)
val () = strptr_free (EIDRMstr)
//
val EILSEQstr = strerror_r_gc (EILSEQ)
val () = println! ("EILSEQ(", EILSEQ, ") = ", EILSEQstr)
val () = strptr_free (EILSEQstr)
//
val EINPROGRESSstr = strerror_r_gc (EINPROGRESS)
val () = println! ("EINPROGRESS(", EINPROGRESS, ") = ", EINPROGRESSstr)
val () = strptr_free (EINPROGRESSstr)
//
val EINTRstr = strerror_r_gc (EINTR)
val () = println! ("EINTR(", EINTR, ") = ", EINTRstr)
val () = strptr_free (EINTRstr)
//
val EINVALstr = strerror_r_gc (EINVAL)
val () = println! ("EINVAL(", EINVAL, ") = ", EINVALstr)
val () = strptr_free (EINVALstr)
//
val EIOstr = strerror_r_gc (EIO)
val () = println! ("EIO(", EIO, ") = ", EIOstr)
val () = strptr_free (EIOstr)
//
val EISCONNstr = strerror_r_gc (EISCONN)
val () = println! ("EISCONN(", EISCONN, ") = ", EISCONNstr)
val () = strptr_free (EISCONNstr)
//
val EISDIRstr = strerror_r_gc (EISDIR)
val () = println! ("EISDIR(", EISDIR, ") = ", EISDIRstr)
val () = strptr_free (EISDIRstr)
//
val ELOOPstr = strerror_r_gc (ELOOP)
val () = println! ("ELOOP(", ELOOP, ") = ", ELOOPstr)
val () = strptr_free (ELOOPstr)
//
val EMFILEstr = strerror_r_gc (EMFILE)
val () = println! ("EMFILE(", EMFILE, ") = ", EMFILEstr)
val () = strptr_free (EMFILEstr)
//
val EMLINKstr = strerror_r_gc (EMLINK)
val () = println! ("EMLINK(", EMLINK, ") = ", EMLINKstr)
val () = strptr_free (EMLINKstr)
//
val EMSGSIZEstr = strerror_r_gc (EMSGSIZE)
val () = println! ("EMSGSIZE(", EMSGSIZE, ") = ", EMSGSIZEstr)
val () = strptr_free (EMSGSIZEstr)
//
val ENAMETOOLONGstr = strerror_r_gc (ENAMETOOLONG)
val () = println! ("ENAMETOOLONG(", ENAMETOOLONG, ") = ", ENAMETOOLONGstr)
val () = strptr_free (ENAMETOOLONGstr)
//
val ENETDOWNstr = strerror_r_gc (ENETDOWN)
val () = println! ("ENETDOWN(", ENETDOWN, ") = ", ENETDOWNstr)
val () = strptr_free (ENETDOWNstr)
//
val ENETRESETstr = strerror_r_gc (ENETRESET)
val () = println! ("ENETRESET(", ENETRESET, ") = ", ENETRESETstr)
val () = strptr_free (ENETRESETstr)
//
val ENETUNREACHstr = strerror_r_gc (ENETUNREACH)
val () = println! ("ENETUNREACH(", ENETUNREACH, ") = ", ENETUNREACHstr)
val () = strptr_free (ENETUNREACHstr)
//
val ENFILEstr = strerror_r_gc (ENFILE)
val () = println! ("ENFILE(", ENFILE, ") = ", ENFILEstr)
val () = strptr_free (ENFILEstr)
//
val ENOBUFSstr = strerror_r_gc (ENOBUFS)
val () = println! ("ENOBUFS(", ENOBUFS, ") = ", ENOBUFSstr)
val () = strptr_free (ENOBUFSstr)
//
val ENODATAstr = strerror_r_gc (ENODATA)
val () = println! ("ENODATA(", ENODATA, ") = ", ENODATAstr)
val () = strptr_free (ENODATAstr)
//
val ENODEVstr = strerror_r_gc (ENODEV)
val () = println! ("ENODEV(", ENODEV, ") = ", ENODEVstr)
val () = strptr_free (ENODEVstr)
//
val ENOENTstr = strerror_r_gc (ENOENT)
val () = println! ("ENOENT(", ENOENT, ") = ", ENOENTstr)
val () = strptr_free (ENOENTstr)
//
val ENOEXECstr = strerror_r_gc (ENOEXEC)
val () = println! ("ENOEXEC(", ENOEXEC, ") = ", ENOEXECstr)
val () = strptr_free (ENOEXECstr)
//
val ENOLCKstr = strerror_r_gc (ENOLCK)
val () = println! ("ENOLCK(", ENOLCK, ") = ", ENOLCKstr)
val () = strptr_free (ENOLCKstr)
//
val ENOLINKstr = strerror_r_gc (ENOLINK)
val () = println! ("ENOLINK(", ENOLINK, ") = ", ENOLINKstr)
val () = strptr_free (ENOLINKstr)
//
val ENOMEMstr = strerror_r_gc (ENOMEM)
val () = println! ("ENOMEM(", ENOMEM, ") = ", ENOMEMstr)
val () = strptr_free (ENOMEMstr)
//
val ENOMSGstr = strerror_r_gc (ENOMSG)
val () = println! ("ENOMSG(", ENOMSG, ") = ", ENOMSGstr)
val () = strptr_free (ENOMSGstr)
//
val ENOPROTOOPTstr = strerror_r_gc (ENOPROTOOPT)
val () = println! ("ENOPROTOOPT(", ENOPROTOOPT, ") = ", ENOPROTOOPTstr)
val () = strptr_free (ENOPROTOOPTstr)
//
val ENOSPCstr = strerror_r_gc (ENOSPC)
val () = println! ("ENOSPC(", ENOSPC, ") = ", ENOSPCstr)
val () = strptr_free (ENOSPCstr)
//
val ENOSRstr = strerror_r_gc (ENOSR)
val () = println! ("ENOSR(", ENOSR, ") = ", ENOSRstr)
val () = strptr_free (ENOSRstr)
//
val ENOSTRstr = strerror_r_gc (ENOSTR)
val () = println! ("ENOSTR(", ENOSTR, ") = ", ENOSTRstr)
val () = strptr_free (ENOSTRstr)
//
val ENOSYSstr = strerror_r_gc (ENOSYS)
val () = println! ("ENOSYS(", ENOSYS, ") = ", ENOSYSstr)
val () = strptr_free (ENOSYSstr)
//
val ENOTCONNstr = strerror_r_gc (ENOTCONN)
val () = println! ("ENOTCONN(", ENOTCONN, ") = ", ENOTCONNstr)
val () = strptr_free (ENOTCONNstr)
//
val ENOTDIRstr = strerror_r_gc (ENOTDIR)
val () = println! ("ENOTDIR(", ENOTDIR, ") = ", ENOTDIRstr)
val () = strptr_free (ENOTDIRstr)
//
val ENOTEMPTYstr = strerror_r_gc (ENOTEMPTY)
val () = println! ("ENOTEMPTY(", ENOTEMPTY, ") = ", ENOTEMPTYstr)
val () = strptr_free (ENOTEMPTYstr)
//
val ENOTSOCKstr = strerror_r_gc (ENOTSOCK)
val () = println! ("ENOTSOCK(", ENOTSOCK, ") = ", ENOTSOCKstr)
val () = strptr_free (ENOTSOCKstr)
//
val ENOTSUPstr = strerror_r_gc (ENOTSUP)
val () = println! ("ENOTSUP(", ENOTSUP, ") = ", ENOTSUPstr)
val () = strptr_free (ENOTSUPstr)
//
val ENOTTYstr = strerror_r_gc (ENOTTY)
val () = println! ("ENOTTY(", ENOTTY, ") = ", ENOTTYstr)
val () = strptr_free (ENOTTYstr)
//
val ENXIOstr = strerror_r_gc (ENXIO)
val () = println! ("ENXIO(", ENXIO, ") = ", ENXIOstr)
val () = strptr_free (ENXIOstr)
//
val EOPNOTSUPPstr = strerror_r_gc (EOPNOTSUPP)
val () = println! ("EOPNOTSUPP(", EOPNOTSUPP, ") = ", EOPNOTSUPPstr)
val () = strptr_free (EOPNOTSUPPstr)
//
val EOVERFLOWstr = strerror_r_gc (EOVERFLOW)
val () = println! ("EOVERFLOW(", EOVERFLOW, ") = ", EOVERFLOWstr)
val () = strptr_free (EOVERFLOWstr)
//
val EPERMstr = strerror_r_gc (EPERM)
val () = println! ("EPERM(", EPERM, ") = ", EPERMstr)
val () = strptr_free (EPERMstr)
//
val EPIPEstr = strerror_r_gc (EPIPE)
val () = println! ("EPIPE(", EPIPE, ") = ", EPIPEstr)
val () = strptr_free (EPIPEstr)
//
val EPROTOstr = strerror_r_gc (EPROTO)
val () = println! ("EPROTO(", EPROTO, ") = ", EPROTOstr)
val () = strptr_free (EPROTOstr)
//
val EPROTONOSUPPORTstr = strerror_r_gc (EPROTONOSUPPORT)
val () = println! ("EPROTONOSUPPORT(", EPROTONOSUPPORT, ") = ", EPROTONOSUPPORTstr)
val () = strptr_free (EPROTONOSUPPORTstr)
//
val EPROTOTYPEstr = strerror_r_gc (EPROTOTYPE)
val () = println! ("EPROTOTYPE(", EPROTOTYPE, ") = ", EPROTOTYPEstr)
val () = strptr_free (EPROTOTYPEstr)
//
val ERANGEstr = strerror_r_gc (ERANGE)
val () = println! ("ERANGE(", ERANGE, ") = ", ERANGEstr)
val () = strptr_free (ERANGEstr)
//
val EROFSstr = strerror_r_gc (EROFS)
val () = println! ("EROFS(", EROFS, ") = ", EROFSstr)
val () = strptr_free (EROFSstr)
//
val ESPIPEstr = strerror_r_gc (ESPIPE)
val () = println! ("ESPIPE(", ESPIPE, ") = ", ESPIPEstr)
val () = strptr_free (ESPIPEstr)
//
val ESRCHstr = strerror_r_gc (ESRCH)
val () = println! ("ESRCH(", ESRCH, ") = ", ESRCHstr)
val () = strptr_free (ESRCHstr)
//
val ETIMEstr = strerror_r_gc (ETIME)
val () = println! ("ETIME(", ETIME, ") = ", ETIMEstr)
val () = strptr_free (ETIMEstr)
//
val ETIMEDOUTstr = strerror_r_gc (ETIMEDOUT)
val () = println! ("ETIMEDOUT(", ETIMEDOUT, ") = ", ETIMEDOUTstr)
val () = strptr_free (ETIMEDOUTstr)
//
val ETXTBSYstr = strerror_r_gc (ETXTBSY)
val () = println! ("ETXTBSY(", ETXTBSY, ") = ", ETXTBSYstr)
val () = strptr_free (ETXTBSYstr)
//
val EWOULDBLOCKstr = strerror_r_gc (EWOULDBLOCK)
val () = println! ("EWOULDBLOCK(", EWOULDBLOCK, ") = ", EWOULDBLOCKstr)
val () = strptr_free (EWOULDBLOCKstr)
//
val EXDEVstr = strerror_r_gc (EXDEV)
val () = println! ("EXDEV(", EXDEV, ") = ", EXDEVstr)
val () = strptr_free (EXDEVstr)
//
} (* end of [val] *)

(* ****** ****** *)

implement main0 () = ()

(* ****** ****** *)

(* end of [libc_string.dats] *)

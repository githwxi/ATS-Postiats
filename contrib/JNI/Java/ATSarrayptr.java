/*
** arrayptr in ATS for use in Java
*/

/* ****** ****** */

public
class
ATSarrayptr
{
//
    public
    static
    native
    long
    make_elt (long asz, long elt) ;
//
    public
    static
    native
    long get_at (long Array, int index) ;
//
    public
    static
    native
    void set_at (long Array, int index, long elt) ;
//
    public static native void free (long Array) ;
//
} // end of [ATSarrayptr]

/* ****** ****** */

/* end of [ATSarrayptr.java] */

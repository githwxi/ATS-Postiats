/*
** Arrayptr in ATS for use in Java
*/

/* ****** ****** */

public
class
Arrayptr
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
    long get_at (long A, long i) ;
//
    public
    static
    native
    void set_at (long A, long i, long x) ;
//
    public static native void free (long A) ;
//
} // end of [Arrayptr]

/* ****** ****** */

/* end of [Arrayptr.java] */

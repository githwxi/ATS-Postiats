class Hello
{
    public
    static
    native
    void helloFrom(String whom);
    static
    {
        //
        // Damn! looking for libHello!!!
	//
	System.loadLibrary("Hello_dats");
	/*
	String PATSHOME = System.getenv("PATSHOME") ;
	System.load(PATSHOME + "/contrib/JNI/TEST/Hello_dats.so");
	*/
    }
    public static void main(String[] args)
    {
	if (args.length >= 1)
        {
	    Hello.helloFrom(args[0]);
	} else {
	    Hello.helloFrom(System.getenv("USER"));
        } ;
	return ;
    }
} /* end of [Hello] */

class Hello
{
    public
    static
    native
    void helloFrom(String whom);
    static
    {
	System.loadLibrary("Hello_dats.so");
    }
    public static void main(String[] args)
    {
	if (args.length >= 1)
        {
	  Hello.helloFrom(args[0]);
	} else {
	  Hello.helloFrom("ATS/Postiats");
        } ;
	return ;
    }
} /* end of [Hello] */

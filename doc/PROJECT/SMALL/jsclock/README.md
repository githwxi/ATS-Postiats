# Running ATS in the Browser

## About

This tutorial gives  a simple overview of how to  compile ATS programs
into Javascript  that can be run  in all the major  browsers available
today. We'll  go through what tools  you'll need and provide  a simple
graphical clock using ATS, Javascript, and the HTML5 Canvas API.

This is a work in progress and is by no means complete.

## Motivation

Since its inception, ATS has been used primarily for low level systems
programming in areas suitable for  C. The combination of dependent and
linear  types provide  a  system where  programmers may  automatically
enforce high  level constraints on  their applications as  an integral
part of development.

Javascript has  become the  language of  the new  web. For  the client
portion  of web  applications,  it  is highly  portable  and now  very
efficient thanks to optimizing engines such as V8 and Spidermonkey. As
more and  more services  are implemented in  the browser,  people have
been  interested  in  seeing  Javascript  as  a  target  language  for
traditional compilers. In  fact, the asm.js project seeks  to define a
small subset of Javascript to serve as a simple assembly language than
ahead-of-time  compiling interpreter  could translate  to native  code
very efficiently.

Naturally, it  is an  interesting idea  to take  existing applications
written in  C and compiling  them down to this  Javascript "assembly".
The  obvious  advantage  is   portability,  this  program  should,  in
principle, run  in most  of the browsers  available today.  Aside from
existing applications, new programs written  in C could perform faster
than  their  Javascript  equivalents.  This  claim  may  require  some
explanation. In our "assembly" subset, all  data from the C program is
outside of garbage collection since it exists in a large static array.
In addition,  most operations in  the code will  be in a  small subset
that an interpreter should easily translate to native code, instead of
the more cumbersome translation of more feature rich javascript.

With  any  performance gains  we  wish  to see  comes  responsibility.
Suddenly, we  are faced  with all  the nasty  pitfalls that  come from
writing  native code  such as  pointer arithmetic,  memory leaks,  and
buffer overflows. Fortunately, ATS was  developed as a tool to address
these problems.  Using this  Javascript backend, we'd  like to  make a
case for writing efficient and reliable programs for the browser.

Furthermore,   Javascript  applications   have   become  advanced   as
manipulating binary  data for audio/video, websockets,  and the canvas
provide  low level  and feature  rich APIs.  Here, both  dependent and
linear  types can  provide  great advantage  in enforcing  constraints
statically that otherwise would be difficult and error prone.

## Dependencies

First, you'll need  the latest ATS compiler which you  can find on the
ATS [website](download-ats).

Next,   install   clang  and   the   (emscripten)[download-emscripten]
compiler. If you want to run  your compiled javascript programs from a
console, you can run them from node.js, which emscripten requires.

## Hello World

After installing  emscripten, you'll  now have  a C/C++  compiler that
outputs  javascript.  For  ATS,  we'll mostly  concerned  with  the  C
functionality provided  by emcc. Make sure  emcc is in your  path, and
try the following small example

    implement main0 = {
      val () = println! "Hello World"
    }

Save this to hello.dats. Next, we'll  need to tell the ATS compiler to
use our alternative C compiler.

    export PATSCCOMP="emcc -I${PATSHOME} -I${PATSHOME}/ccomp/runtime -L${PATSHOME}/ccomp/atslib/lib -I${PATSHOME}/contrib"

and finally, produce and run our final js file.

    patscc -o hello.js hello.dats
    node hello.js

If all is well, you'll see the hello message displayed in the console.
With most of the standard libc at your finger tips, you should be able
to utilize all the features found in ATS2 for writing programs.

## Utilizing Javascript Interfaces

Almost  any  client side  application  needs  to interface  with  APIs
provided  by  the  browser.  Some  examples  include  websockets,  DOM
elements, and the 2D/3D canvas. Here, we outline a couple helpful tips
for  working  with Javascript  Since  ATS  interfaces simply  with  C,
refering  to  emscripten's  documentation  will  be  most  helpful  if
something doesn't work  right. In the future, we would  like to remove
the dependency on emscripten and compile ATS right to Javascript.

### Functions in Javascript

Suppose there's some functionality we would like that's implemented in
the browser, such  as refreshing a div container. Obviously,  C has no
notion of the  DOM, so we wrap this function  in an external function.
In ATS, we use the following declaration.

    extern fun update_display (): void = "ext#"

This designates "update_display" to  be externally defined. This means
that the  C compiler will  generate a stub for  it and let  the linker
resolve it to  the correct symbol. We can tell  emscripten to look for
this symbol  in a special javascript  file we designate as  a library.
To get a good idea of how this works, check out the library.js file in
this directory that wraps the HTML5 Canvas API with functions ATS can
understand. 

To make a library.js for the simple update display example, add the
following to it

    /* Our library object. */
    var LibaryUpdate = {
      update_display: function () {
        var display = document.getElementById("user-display");
        display.innerHTML("Display Updated!");
      };
    };
    
    /* Merge our library with the default */
    mergeInto(LibraryManager.library, LibraryUpdate);

Now, we need  to tell emscripten where to find  our library. Modifying
our call to patscc will do the trick.

  patscc --js-libary library.js -o update.html update.dats

Where update.dats contains your application's code. This will create a
standalone html file with your Javascript program embedded in it.

### Javascript Objects

The only  types we can  share between  Javascript and C  are primitive
types such as  integers, floats, and doubles. So how  then can we work
with things like HTML documents, or DOM elements? One easy solution is
to use integers as offsets into  containers you have in Javascript. We
use this technique in keeping track  of drawing contexts which have no
representation in C.

Let's create an  abstract linear type in ATS to  represent our drawing
context.

    absvtype context

Since it's abstract  and boxed, a context is  automatically a pointer.
When we create a context, we give the id of the canvas providing it.
  
    extern fun make_canvas (id: string): context

In Javascript,  we are  given a  pointer to a  string. Let's  use that
pointer as an id for the context.

    Clock: {
      contexts: {},
    },
    make_context: function (ptr) {
        var id = Pointer_stringify(ptr);
        var canvas = document.getElementById(id);

        if(canvas.getContext) {
            Clock.contexts[ptr] = canvas.getContext("2d");
        } else {
            throw "HTML5 Canvas is not supported";
        }
        
        return ptr; 
    }

Now, when we call a function on our context, we use the value in ATS as
a key into our contexts lookup table. For example, here's the wrapper
for rotating rotating the orientation of our canvas.

    fun rotate (_: !context, radians: double): void = "ext#"

    rotate: function (ptr, radians) {
        Clock.contexts[ptr].rotate(radians);
    }

When it  comes time to free  our context, which is  required for every
linear type in ATS,  we just set the context refered to  by the key to
null. If  context were some regular  object, it could now  possibly be
reclaimed by garbage collection.

    fun free_context (_: context): void = "ext#"

    free_context: function (ptr) {
        Clock.contexts[ptr] = null;
    }

This gives  you a  simple example  of how  to wrap  Javascript objects
through abstract types in ATS.

### Modifying ATS Records

A record in ATS boils down to a  regular C struct. If we want to fetch
some information  from Javascript, such as  from a timer, we  can only
pass a  pointer to the struct  to our external functional.  Using this
pointer (which  is, after all  just an  integer) we use  the functions
provided by  the emscripten  library to "dereference"  it and  set the
fields appropriately.

For example,  when we make a  clock we want the  current hour, minute,
second, and, since  we want a nice analog  looking clock, millisecond.
Of course,  we can do  this all in C,  but since the  library function
gets deferred in Javascript anyway, let's  make a nice wrapper. In ATS
a point in time is represented by the following type:

    typedef wallclock = @{
      hours= double,
      minutes= double,
      seconds= double
    }

    extern
    fun wallclock_now (_: &wallclock? >> wallclock): void = "ext#"

This is just a  regular struct of doubles. Using a  double lets us put
the hands at points between numbers and gives a nice smooth transition
of  time. The  initialize function  "wallclock_now" takes  a reference
(pointer) to a wallclock record and initializes its fields. We now see
how we implement this in our library.js file.

    wallclock_now: function (ptr) {
        /* 
           Assume that the layout of a struct in memory isn't
           changed by alignment optimizations.
        */
        var now = new Date();

        var mils = now.getMilliseconds();
        var secs = now.getSeconds() + mils / 1000.0;
        var mins = now.getMinutes() + secs / 60.0;
        var hours = (now.getHours() % 12) + mins / 60.0;
        
        /*
          Note that we have to do pointer arithmetic to set the fields
          of our struct.
        */
        Module.setValue(ptr, hours, "double");
        Module.setValue(ptr + 8, mins, "double");
        Module.setValue(ptr + 16, secs, "double");
    }

After  calling "wallclock_now",  the struct  pointed at  by "ptr"  now
contains the  hour, minute, and  second given  by the Date  object. Of
course, this  isn't very convenient  or easy  to use, but  with proper
library support it could be made simpler.

## Code Example: A Wall Clock

In this folder you'll see all these  ideas put into practice to make a
simple clock using  the HTML5 Canvas API. Rendering is  done using the
requestAnimationFrame   interface    which   makes    an   interesting
demonstration of higher order functions between ATS and Javascript.

You can  compile the clock  yourself or view  it [here][running-clock]
through any browser. To see how it works, check out myclock0.dats.

[download-ats]: http://www.ats-lang.org/DOWNLOAD/#ATS_packages
[download-emscripten]: http://github.com/kripken/emscripten
[running-clock]: http://cs-people.bu.edu/wdblair/jsclock/myclock0.html
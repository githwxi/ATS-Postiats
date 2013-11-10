# Generating JS code from ATS source

## About

This tutorial gives a simple overview of an approach to compiling ATS
programs into Javascript that can be run in all the major web browsers
available today. We will go through what tools you need and provide a
simple wall clock implementation based on ATS, Javascript, and the HTML5
Canvas API.

This is a work in progress and we encourage interested people to
participate.

## Motivation

Since its inception, ATS has been used primarily for low-level systems
programming in areas suitable for C. The availability of advanced types in
ATS such as dependent types and linear types provides a highly expressive
and flexible means for programmers to capture (sophisticated) invariants in
their programs as an integral part of program construction.

Javascript (JS) has become the de facto language of the new web. For the
client portion of web applications, JS is not only highly portable but also
very efficient due to optimizing engines such as V8 and Spidermonkey. As
more and more services are implemented in web browsers, people have been
interested in seeing JS as a target language for traditional compilers. In
fact, the asm.js project seeks to define a small subset of JS to serve as a
simple assembly language that can be efficiently translated to native code
by an ahead-of-time compiling interpreter

Naturally, it is an interesting idea to take existing applications written
in C and compiling them down to this JS "assembly".  The obvious advantage
is portability, since this program should, in principle, run in most of the
browsers available today.  Aside from existing applications, new programs
written in C can perform more efficiently, both time-wise and memory-wise,
than their counterparts written in JS directly.  In this "assembly" subset
of JS, all data from the C program is outside of garbage collection since
it exists in a large static array.  Also, most operations in the code will
be in a small subset that should be much more suitable for an ahead-of-time
compiling interpreter to perform efficient translation than the general
feature-rich JS.

With any performance gains we wish to see comes potential responsibility as
we are faced with all the pitfalls that are often associated with writing
native code such as erroneous pointer arithmetic, memory leaks, and buffer
overflows. Fortunately, ATS has long been developed as a tool to
effectively address these programming pitfalls. With this JS backend, we
would like to make a convincing case for writing efficient and reliable
programs to run on web browsers.

Furthermore, JS applications have become advanced as manipulating binary
data for audio/video, websockets, and canvases provide low-level and
feature-rich APIs.  We expect that advanced types such as dependent linear
and linear types to provide great advantages in enforcing constraints
statically that would otherwise be difficult and error-prone to do.

## Dependencies

First, you'll need  the latest ATS compiler which you  can find on the
ATS [website][download-ats].

Next, install clang and the [emscripten][download-emscripten] compiler. If
you want to run your compiled javascript programs from a console, you can
run them from node.js, which emscripten requires.

## Hello, world!

After installing emscripten, you'll now have a C/C++ compiler that outputs
javascript.  For ATS, we'll mostly concerned with the C functionality
provided by emcc. Make sure emcc is in your path, and try the following
small example

    implement main0 () = {
      val () = println! "Hello, world!"
    }

Save this to hello.dats. Next, we'll need to tell the ATS compiler to use
our alternative C compiler.

    export PATSCCOMP="emcc -Wno-warn-absolute-paths -D_XOPEN_SOURCE -I${PATSHOME} -I${PATSHOME}/ccomp/runtime"

and finally, produce and run our final js file.

    patscc -o hello.js hello.dats
    node hello.js

If all goes well, you'll see the message "Hello, world!" displayed in the
console.  With most of the standard libc at your finger tips, you should be
able to utilize all the features found in ATS2 for writing programs.

## Utilizing Javascript Interfaces

Almost any client side application needs to interface with APIs provided by
the browser.  Some examples include websockets, DOM elements, and the 2D/3D
canvas. Here, we outline a couple helpful tips for working with Javascript.
Since ATS interfaces simply with C, refering to emscripten's documentation
will be most helpful if something does not work right. In the future, we
would like to remove the dependency on emscripten and compile ATS right to
Javascript.

### Functions in Javascript

Suppose there's some functionality we would like that's implemented in the
browser, such as refreshing a div container. Obviously, C has no notion of
the DOM, so we wrap this function in an external function.  In ATS, we use
the following declaration.

    extern fun update_display (): void = "ext#"

This designates "update_display" to be externally defined. This means that
the C compiler will generate a stub for it and let the linker resolve it to
the correct symbol. We can tell emscripten to look for this symbol in a
special javascript file we designate as a library.  To get a good idea of
how this works, check out the library.js file in this directory that wraps
the HTML5 Canvas API with functions ATS can understand.

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

Now, we need to tell emscripten where to find our library. Modifying our
call to patscc will do the trick.

  patscc --js-libary library.js -o update.html update.dats

Where update.dats contains your application's code. This will create a
standalone html file with your Javascript program embedded in it.

### Javascript Objects

The only types we can share between Javascript and C are primitive types
such as integers, floats, and doubles. So how then can we work with things
like HTML documents, or DOM elements? One easy solution is to use integers
as offsets into containers you have in Javascript. We use this technique in
keeping track of drawing contexts which have no representation in C.

Let's create an abstract linear type in ATS to represent our drawing
context.

    absvtype canvas2d

Since it's abstract and boxed, a context is automatically a pointer.  When
we create a context, we give the id of the canvas providing it.
  
    extern fun make_canvas (id: string): canvas2d

In Javascript, we are given a pointer to a string. Let's use that pointer
as an id for the context.

    Canvas: {
      contexts: {},
    },

    canvas2d_make: function (ptr) {
        var id = Pointer_stringify(ptr);
        var canvas = document.getElementById(id);

        if(canvas.getContext) {
            Canvas.contexts[ptr] = canvas.getContext("2d");
        } else {
            throw "canvas2d_make: HTML5 Canvas is not supported";
        }
        
        return ptr; 
    }

When we call a function on our context, we use the value in ATS as a
key into the lookup table for contexts. For example, here's the wrapper for
rotating rotating the orientation of our canvas.

    fun rotate (!canvas2d, angle: double): void = "ext#"

    rotate: function (ptr, angle) { Canvas.contexts[ptr].rotate(angle); }

When it comes time to free our context, which is required for every linear
type in ATS, we just set the context refered to by the key to null. If
context were some regular object, it could now possibly be reclaimed by
garbage collection.

    fun canvas2d_free (canvas2d): void = "ext#"

    canvas2d_free: function (ptr) { Canvas.contexts[ptr] = null; }

This gives you a simple example of how to wrap Javascript objects through
abstract types in ATS.

### Reading the Current Time in JS

Clearly, we need to be able to read the current time in order to make a
running clock. Let us first declare as follows the interface of a function
for reading the current time:

    extern
    fun wallclock_now
    (
      nhr: &double? >> double, nmin: &double? >> double, nsec: &double? >> double
    ) : void = "ext#"

While we can certainly implement such a function in C, implementing it in JS
seems more convenient (though it may be much less efficient):

    wallclock_now:
    function (nhr, nmin, nsec) {
        var now = new Date();
        var mils = now.getMilliseconds();
        var secs = now.getSeconds() + mils / 1000.0;
        var mins = now.getMinutes() + secs / 60.0;
        var hours = (now.getHours() % 12) + mins / 60.0;
        Module.setValue(nhr, hours, "double");
        Module.setValue(nmin, mins, "double");
        Module.setValue(nsec, secs, "double");
    }

After wallclock_now is called on three given pointers nhr, nmin
and nsec, the memory locations to which they point are set to contain
doubles representing the current hour, minute, and second, respectively.

## Code Example: A Wall Clock

In this folder you'll see all these ideas put into practice to make a
simple clock based the HTML5 Canvas API. Rendering is done using the
requestAnimationFrame interface which makes an interesting demonstration of
passing higher-order functions between ATS and Javascript.

You can compile the clock yourself or view it [here][running-clock] through
a commonly available browser. To see how it works, check out both
myclock0.dats and myclock0_lib.js. There is also a Makefile available for
compilation.

[download-ats]: http://www.ats-lang.org/DOWNLOAD/#ATS_packages
[download-emscripten]: http://github.com/kripken/emscripten
[running-clock]: http://www.ats-lang.org/TEMPATS/JS/JSclock/myclock0.html

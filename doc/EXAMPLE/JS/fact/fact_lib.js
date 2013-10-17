/**
 *  HX-2013-10
*/

FactLib = {
//
    JS_document_element_addEventListener_fun:
    function (idx, type, func) {
        var type2 = Pointer_stringify(type);
        var func2 = Runtime.getFuncWrapper(func, 'vi');
        MyDocument.contexts[idx].addEventListener
	(
	    type2, function(event) { func2(MyDocument.objadd(event)); return; }
	);
    }
//
}

/* ****** ****** */

mergeInto(LibraryManager.library, FactLib);

/* ****** ****** */
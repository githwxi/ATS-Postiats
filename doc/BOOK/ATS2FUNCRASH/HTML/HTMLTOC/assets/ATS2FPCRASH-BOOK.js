//-*- coding:utf-8; mode:js; indent-tabs-mode:nil; c-basic-offset:3; -*-

// Author: Yannick Duchêne <yannick_duchene@yahoo.fr>
// Date: 2015-02-09
// License: MIT

// To be used with INTPROGINATS, the ATS2 language introduction book, authored
// by Hongwei Xi.

// ###########################################################################
// JSLint configuration: do not remove.

/*jslint adsafe:false */
/*jslint bitwise:true */
/*jslint browser:false */
/*jslint continue:true */
/*jslint debug:false */
/*jslint eqeqeq:true */
/*jslint evil:false */
/*jslint forin:true */
/*jslint nomen:false */
/*jslint plusplus:true */
/*jslint undef:true */

/*global self */
/*global document */
/*global window */
/*global alert */
/*global XMLHttpRequest */

// ###########################################################################

// define and invoke an anonymous function to not pollute outer‑namespace.

(function () {

   var contentClassName    = "content";     // Constant.
   var footerClassName     = "NAVFOOTER";   // Constant.
   var headerClassName     = "NAVHEADER";   // Constant.
   var selectedClassName   = "selected";    // Constant.
   var tocClassName        = "TOC";         // Constant.
   var tocSidebarClassName = "sidebar TOC"; // Constant.
   var tocSourceUrl        = "book1.html";  // Constant.

   var theToc = null;

   // ========================================================================

   /* Return the file name part of an URL.
    * Ex. if `url` is `"foo.com/page.html#bar"`, return `"page.html"`. */
   function fileName(url) {

      var i = null;
      var result = url;

      if (result !== null) {

         i = result.lastIndexOf("/");
         if (i !== -1) {
            result = result.substr(i + 1);
         }

         i = result.indexOf("#");
         if (i !== -1) {
            result = result.substr(0, i);
         }
      }

      return result;
   }

   // ------------------------------------------------------------------------

   /* Return the first element whose class name is exactly `className`,
    * in `root`, excluding `root` itself. */
   function getElementByClassName(root, className) {

      var element  = null;
      var elements = null;
      var i        = null;
      var result   = null;

      if (root !== null) {
         elements = root.getElementsByTagName("*");
         i = 0;

         while (i < elements.length) {
            element = elements.item(i);
            if (element.className === className) {
               result = element;
               break;
            }
            i += 1;
         }
      }

      return result;
   }

   // ------------------------------------------------------------------------

   /* Return the text response of an `XMLHttpRequest` instance, checking
    * the response status. */
   function getResponseText(xhr) {

      var result = null;
      var status = null;

      if (xhr !== null) {
         status = xhr.status;
         if ((status === 0) || (status === 200) || (status === 304)) {
            result = xhr.responseText;
         }
      }

      return result;
   }

   // ========================================================================

   /* Return all anchors in `root`, whose `href` file name
    * matches `theFileName`. */
   function getAnchorsMatchingFileName(root, theFileName) {

      var anchorFileName = null;
      var anchor         = null;
      var anchors        = null;
      var i              = 0;
      var result         = [];

      if (root !== null) {
         anchors = root.getElementsByTagName("A");
         while (i < anchors.length) {
            anchor = anchors.item(i);
            anchorFileName = fileName(anchor.href);
            if (anchorFileName === theFileName) {
               result.push(anchor);
            }
            i += 1;
         }
      }

      return result;
   }

   // ------------------------------------------------------------------------

   /* Return the chapter element of the document. It's the element which
    * directly comes next to the header element, which is itself identified
    * by its class name. It can't be identified by its class name, as its
    * class name varies from page to page. */
   function getChapterElementFromCurrentDocument() {

      var header  = getElementByClassName(document.body, headerClassName);
      var result  = null;
      var sibling = null;

      // Get the `DIV` following the header.
      if (header !== null) {
         sibling = header.nextSibling;
         while (sibling !== null) {
            if (sibling.tagName === "DIV") {
               result = sibling;
               break;
            }
            sibling = sibling.nextSibling;
         }
      }

      return result;
   }

   // ------------------------------------------------------------------------

   /* Return the footer element of the document, which is identified
    * by its class name. */
   function getFooterElementFromCurrentDocument() {
      var result = getElementByClassName(document.body, footerClassName);
      return result;
   }

   // ------------------------------------------------------------------------

   /* Return the header element of the document, which is identified
    * by its class name. */
   function getHeaderElementFromCurrentDocument() {
      var result = getElementByClassName(document.body, headerClassName);
      return result;
   }

   // ------------------------------------------------------------------------

   /* Return the `DT` element to which the `element` belongs. Note: if the
    * element is the `DT` itself, then retun it. */
   function getParentDt(element) {
      var parent = element;
      var result = null;
      while (parent !== null) {
         if (parent.tagName === "DT") {
            result = parent;
            break;
         }
         parent = parent.parentElement;
      }
      return result;
   }

   // ------------------------------------------------------------------------

   /* Return the TOC element extracted from the HTML DOM parsed from `text`.
    * The TOC is identified by its class name. */
   function getTocElementFromText(text) {

      var html   = null;
      var result = null;

      if (text !== null) {
         html = document.createElement("HTML");
         html.innerHTML = text;
            // More portable than this:
            //      parser = new DOMParser();
            //      htmlDocument = parser.parseFromString(text, "text/html");

         result = getElementByClassName(html, tocClassName);
      }

      return result;
   }

   // ========================================================================

   /* Give all the `DT` elements to which the `anchors` belongs, the
    * “selected” class name. */
   function markDtsAsSelected(anchors) {
      var anchor = null;
      var dt     = null;
      var i      = null;
      if (anchors !== null) {
         i = 0;
         while (i < anchors.length) {
            anchor = anchors[i];
            dt = getParentDt(anchor);
            if (dt !== null) {
               dt.className = selectedClassName;
            }
            i += 1;
         }
      }
   }

   // ------------------------------------------------------------------------

   /* Given an anchor, show the DL element underneath, that is, show the DL
    * element contained in the DD element designated by the DT owning the
    * anchor. */
   function showInnerDl(anchor) {

      var child   = null;
      var dd      = null;
      var dl      = null;
      var dt      = null;
      var parent  = null;
      var sibling = null;

      // Search for owning DT
      dt = getParentDt(anchor);

      // Search for designated DD (break if a DT is encountered before).
      if (dt !== null) {
         sibling = dt.nextSibling;
         while(sibling !== null) {
            if (sibling.tagName === "DD") {
               dd = sibling;
               break;
            }
            if (sibling.tagName === "DT") {
               dd = null;
               break;
            }
            sibling = sibling.nextSibling;
         }
      }

      // Search for contained DL
      if (dd !== null) {
         child = dd.firstElementChild;
         if (child.tagName === "DL") {
            dl = child;
         }
      }

      // Display it
      if (dl !== null) {
         dl.style.display = "block";
      }
   }

   // ------------------------------------------------------------------------

   /* Show the parents DL indirectly owning the anchor. */
   function showParentDls(anchor) {
      var parent = null;
      if (anchor !== null) {
         parent = anchor.parentElement;
         while (parent !== null) {
            if (parent.tagName === "DL") {
               parent.style.display = "block";
            }
            parent = parent.parentElement;
         }
      }
   }

   // ------------------------------------------------------------------------

   /* If the TOC is less tall than the window height, then give it the
    * `display:fixed` property, so that it stay fixed while the document is
    * scrolled, as the TOC does not need to be scrallable. Otherwise, if
    * the TOC is taller than the window height, give it the `display:absolute`
    * property, so that it can be scrolled along to with the document. */
   function updateTocPositioning() {
      if (theToc !== null) {
         if (window.innerHeight > theToc.clientHeight) {
            theToc.style.position = "fixed";
         }
         else {
            theToc.style.position = "absolute";
         }
      }
   }

   // ========================================================================

   /* When the HTML document containing the global TOC is received, fetch
    * the TOC from this document, move the header, content and footer in
    * a DIV element, insert the global TOC before this DIV, then finally
    * show DLs and decorated DT, according to the URL of the current
    * document. */
   function onTocLoaded() {

      // Recieves `this` of an `XMLHttpRequest` instance.

      var body             = document.body;
      var chapter          = getChapterElementFromCurrentDocument();
      var div              = null;
      var documentFileName = fileName(document.URL);
      var footer           = getFooterElementFromCurrentDocument();
      var header           = getHeaderElementFromCurrentDocument();
      var i                = null;
      var matchingAnchor   = null;
      var matchingAnchors  = null;
      var ready            = true;
      var text             = null;
      var toc              = null;

      text = getResponseText(this);

      if (text !== null) {
         toc = getTocElementFromText(text);
      }

      if (toc !== null) {
         matchingAnchors = getAnchorsMatchingFileName(toc, documentFileName);
      }

      if (matchingAnchors.length > 0) {
         matchingAnchor = matchingAnchors[0];
      }

      ready = ready && (toc !== null);
      ready = ready && (chapter !== null);
      ready = ready && (header !== null);
      ready = ready && (footer !== null);
      ready = ready && (matchingAnchor !== null);

      if (ready) {
         div = document.createElement("DIV");
         div.className = contentClassName;
         body.insertBefore(div, body.firstChild);
         div.appendChild(header); // This moves the element
         div.appendChild(chapter); // This moves the element
         div.appendChild(footer); // This moves the element
         toc.className = tocSidebarClassName;
         div.parentElement.insertBefore(toc, div);
         showParentDls(matchingAnchor);
         showInnerDl(matchingAnchor);
         markDtsAsSelected(matchingAnchors);
         theToc = toc;
         updateTocPositioning();
         window.onresize = updateTocPositioning;
      }
   }

   // ========================================================================

   /* Create a request for the HTML page containing the main TOC, which will
    * later trigger `onTocLoaded` when the the document is received. */
   function main() {
      var xhr = new XMLHttpRequest();
      xhr.onload = onTocLoaded;
      xhr.open("GET", tocSourceUrl);
      xhr.responseType = "text";
         // `text` and not `document`, for portability.
         // Will parse text as HTML later, in `getTocElementFromText`.
      xhr.send();
   }

   // ------------------------------------------------------------------------

   // Use `main();` when the script is invoked from the end of BODY,
   // otherwise, use `window.onload = main();` if the script is invoked
   // from the HEAD. Edit this line accordingly:
   main();

}());

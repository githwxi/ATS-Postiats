//-*- coding:utf-8; mode:js; indent-tabs-mode:nil; c-basic-offset:3; -*-

// ###########################################################################
// JSLint configuration
// ===========================================================================
// Do not remove.

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

   var chapterClassName    = "chapter";     // Constant.
   var contentClassName    = "content";     // Constant.
   var footerClassName     = "NAVFOOTER";   // Constant.
   var headerClassName     = "NAVHEADER";   // Constant.
   var selectedClassName   = "selected";    // Constant.
   var tocClassName        = "TOC";         // Constant.
   var tocSidebarClassName = "sidebar TOC"; // Constant.
   var tocSourceUrl        = "book1.html";  // Constant.
   var xhr                 = null;

   // ========================================================================

   function fileName(url) {
      var i = null;
      var result = null;
      if (url !== null) {
         i = url.lastIndexOf("/");
         result = url.substr(i + 1);
      }
      return result;
   }

   // ------------------------------------------------------------------------

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

   function getChapterElementFromCurrentDocument() {
      var result = getElementByClassName(document.body, chapterClassName);
      return result;
   }

   // ------------------------------------------------------------------------

   function getEntryMatchingFileName(toc, theFileName) {

      var anchors = toc.getElementsByTagName("A");
      var anchor = null;
      var entryFileName = null;
      var i = 0;
      var result = null;

      while (i < anchors.length) {
         anchor = anchors.item(i);
         if (fileName(anchor.href) === theFileName) {
            result = anchor;
            break;
         }
         i += 1;
      }
      return result;
   }

   // ------------------------------------------------------------------------

   function getFooterElementFromCurrentDocument() {
      var result = getElementByClassName(document.body, footerClassName);
      return result;
   }

   // ------------------------------------------------------------------------

   function getHeaderElementFromCurrentDocument() {
      var result = getElementByClassName(document.body, headerClassName);
      return result;
   }

   // ------------------------------------------------------------------------

   function getTocElementFromText(text) {

      var html     = null;
      var result   = null;

      if (text !== null) {
         html = document.createElement("HTML");
         html.innerHTML = text;
            // More portable than this:
            //      parser=new DOMParser();
            //      htmlDocument=parser.parseFromString(text, "text/html");

         result = getElementByClassName(html, tocClassName);
      }

      return result;
   }

   // ------------------------------------------------------------------------

   function showInnerDl(element) {
      var parent = null;
      var dt = null;
      var dd = null;
      var dl = null;
      var sibling = null;
      var child = null;

      // Search for current DT
      if (element !== null) {
         if (element.tagName === "DT") {
            dt = element;
         }
         else {
            parent = element.parentElement;
            while (parent !== null) {
               if (parent.tagName === "DT") {
                  dt = parent;
                  break;
               }
               parent = parent.parentElement;
            }
         }
      }

      // Search corresponding DD
      if (dt !== null) {
         sibling = dt.nextSibling;
         while(sibling !== null) {
            if (sibling.tagName === "DD") {
               dd = sibling;
               break;
            }
         }
      }

      // Search for inner DL
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

   function showParentDls(element) {
      var parent = null;
      if (element !== null) {
         parent = element.parentElement;
         while (parent !== null) {
            if (parent.tagName === "DL") {
               parent.style.display = "block";
            }
            parent = parent.parentElement;
         }
      }
   }

   // ========================================================================

   function onLoad() {
      var text = getResponseText(this);
      var toc = getTocElementFromText(text);
      var chapter = getChapterElementFromCurrentDocument();
      var header = getHeaderElementFromCurrentDocument();
      var footer = getFooterElementFromCurrentDocument();
      var currentEntry = null;
      var div = null;
      var body = document.body;
      var ready = true;

      if (toc !== null) {
         currentEntry = getEntryMatchingFileName(toc, fileName(document.URL));
      }
      ready = ready && (toc !== null);
      ready = ready && (chapter !== null);
      ready = ready && (header !== null);
      ready = ready && (footer !== null);
      ready = ready && (currentEntry !== null);

      if (ready) {
         div = document.createElement("DIV");
         div.className = contentClassName;
         body.insertBefore(div, body.firstChild);
         div.appendChild(header); // This moves the element
         div.appendChild(chapter); // This moves the element
         div.appendChild(footer); // This moves the element
         toc.className = tocSidebarClassName;
         div.parentElement.insertBefore(toc, div);
         showParentDls(currentEntry);
         showInnerDl(currentEntry);
         currentEntry.className = selectedClassName;
      }
   }

   // ------------------------------------------------------------------------

   xhr = new XMLHttpRequest();
   xhr.onload = onLoad;
   xhr.open("GET", tocSourceUrl);
   xhr.responseType = "text";
      // `text` and not `document`, for portability.
      // Will parse text as HTML later, in `xhr.onload`.
   xhr.send();

}());
